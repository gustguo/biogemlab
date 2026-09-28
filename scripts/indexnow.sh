#!/usr/bin/env bash
# IndexNow pusher — www.biogemlab.com
# Notifies Bing (and other participating engines) to recrawl changed URLs.
# Key file lives at site root by IndexNow design and is intentionally public.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONF="$REPO_DIR/scripts/indexnow.conf"
STATE="$REPO_DIR/.git/indexnow-last-commit"

# shellcheck source=indexnow.conf
source "$CONF"

API="https://api.indexnow.org/indexnow"
KEY_LOCATION="https://${SITE_HOST}/${INDEXNOW_KEY_FILE}"

die() { echo "indexnow: $*" >&2; exit 1; }

url_from_rel() {
  local rel="$1"
  case "$rel" in
    index.html)        echo "https://${SITE_HOST}/" ;;
    404.html|CNAME|robots.txt|llms.txt) return 1 ;;
    *.html)            echo "https://${SITE_HOST}/${rel}" ;;
    *)                 return 1 ;;
  esac
}

post_batch() {
  local payload="$1" n="$2"
  [ "$n" -eq 0 ] && { echo "indexnow: nothing to submit"; exit 0; }
  local http
  http=$(curl -sS -o /tmp/indexnow-resp.txt -w '%{http_code}' \
    -X POST "$API" \
    -H 'Content-Type: application/json; charset=utf-8' \
    --data-binary "$payload" --max-time 30) || die "curl failed"
  echo "indexnow: submitted $n URL(s) -> HTTP $http"
  case "$http" in
    200) ;;
    202) echo "indexnow: 202 Accepted (key validation pending)" ;;
    4*|5*) echo "indexnow: response body:"; cat /tmp/indexnow-resp.txt; exit 1 ;;
  esac
}

make_payload() {
  local urls=("$@")
  local list
  list=$(printf '"%s",' "${urls[@]}")
  printf '{"host":"%s","key":"%s","keyLocation":"%s","urlList":[%s]}' \
    "$SITE_HOST" "$INDEXNOW_KEY" "$KEY_LOCATION" "${list%,}"
}

cmd_push() {
  # Diff HEAD vs last submitted commit; map changed .html to URLs.
  local last
  if [ -f "$STATE" ]; then
    last=$(cat "$STATE")
  else
    echo "indexnow: no state file ($STATE) — run 'push-all' once, or pass explicit URLs" >&2
    exit 2
  fi
  git -C "$REPO_DIR" rev-parse --verify "$last" >/dev/null 2>&1 \
    || die "state commit $last not found; run 'push-all' to resync"
  local current; current=$(git -C "$REPO_DIR" rev-parse HEAD)
  [ "$last" = "$current" ] && { echo "indexnow: no new commits since last push"; exit 0; }

  local urls=() rel
  while IFS= read -r rel; do
    url_from_rel "$rel" && urls+=("$(url_from_rel "$rel")")
  done < <(git -C "$REPO_DIR" diff --name-only "$last" "$current" -- '*.html')

  [ "${#urls[@]}" -eq 0 ] && { echo "$current" > "$STATE"; echo "indexnow: HTML unchanged, state synced"; exit 0; }

  post_batch "$(make_payload "${urls[@]}")" "${#urls[@]}"
  echo "$current" > "$STATE"
}

cmd_push_all() {
  local urls=() loc
  while IFS= read -r loc; do urls+=("$loc"); done \
    < <(grep -o '<loc>[^<]*</loc>' "$REPO_DIR/sitemap.xml" | sed 's/<[^>]*>//g')
  [ "${#urls[@]}" -eq 0 ] && die "no URLs parsed from sitemap.xml"
  post_batch "$(make_payload "${urls[@]}")" "${#urls[@]}"
  git -C "$REPO_DIR" rev-parse HEAD > "$STATE"
}

cmd_push_url() {
  [ "$#" -ge 1 ] || die "usage: $0 push-url URL [URL...]"
  post_batch "$(make_payload "$@")" "$#"
  git -C "$REPO_DIR" rev-parse HEAD > "$STATE" 2>/dev/null || true
}

case "${1:-push}" in
  push)      cmd_push ;;
  push-all)  cmd_push_all ;;
  push-url)  shift; cmd_push_url "$@" ;;
  *)         echo "usage: $0 [push | push-all | push-url URL...]" >&2; exit 2 ;;
esac

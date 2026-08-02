/* BioGem Lab — Shared JS */

// Scroll reveal animation
const observerOptions = { root: null, rootMargin: '0px', threshold: 0.1 };
const revealObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('active');
            revealObserver.unobserve(entry.target);
        }
    });
}, observerOptions);

document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.reveal').forEach(el => revealObserver.observe(el));
});

// Highlight current nav item
const currentPage = window.location.pathname.split('/').pop() || 'index.html';
document.querySelectorAll('nav a').forEach(link => {
    if (link.getAttribute('href').includes(currentPage)) {
        link.classList.add('text-brand-gold');
    }
});

// Mobile menu toggle
function toggleMobileMenu() {
    const menu = document.getElementById('mobile-menu');
    if (menu) {
        menu.classList.toggle('hidden');
    }
}

// Redesign header mobile menu (lab.css chrome)
function labToggleMenu() {
    const menu = document.getElementById('labMobileMenu');
    const btn = document.getElementById('labBurger');
    if (menu) {
        const open = menu.classList.toggle('open');
        if (btn) btn.setAttribute('aria-expanded', String(open));
    }
}
document.addEventListener('DOMContentLoaded', () => {
    const menu = document.getElementById('labMobileMenu');
    if (menu) {
        menu.querySelectorAll('a').forEach(a =>
            a.addEventListener('click', () => menu.classList.remove('open')));
    }
});

// Form validation helper
function validateEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

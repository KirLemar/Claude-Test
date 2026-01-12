// RFX Landing Page JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Mobile Menu Toggle
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const navLinks = document.querySelector('.nav-links');

    if (mobileMenuBtn && navLinks) {
        mobileMenuBtn.addEventListener('click', function() {
            this.classList.toggle('active');
            navLinks.classList.toggle('active');
        });

        // Close menu when clicking on a link
        navLinks.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => {
                mobileMenuBtn.classList.remove('active');
                navLinks.classList.remove('active');
            });
        });
    }

    // Smooth Scroll for Navigation Links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Header Scroll Effect
    const header = document.querySelector('.header');
    let lastScroll = 0;

    window.addEventListener('scroll', () => {
        const currentScroll = window.pageYOffset;

        if (currentScroll > 100) {
            header.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.3)';
        } else {
            header.style.boxShadow = 'none';
        }

        lastScroll = currentScroll;
    });

    // Join Movement Tabs
    const joinOptions = document.querySelectorAll('.join-option');
    const joinContent = document.querySelector('.join-content');

    const tabContent = {
        coaches: {
            title: 'COACHES',
            text: [
                'Become a certified RFX instructor by joining Acadelo – high-energy, diverse sports fitness and player experience that your clients will love, while growing your reputation and becoming part of a movement bigger than the game itself.',
                'Get the free weekly 50-60-min course content to add certification progression overview/fair hints...'
            ]
        },
        player: {
            title: 'PLAYER',
            text: [
                'Join RFX as a player and experience the ultimate fusion of HIIT training and racket sports. Our sessions are designed for all fitness levels, from beginners to seasoned athletes.',
                'Get access to exclusive classes, track your progress, and become part of a community that shares your passion for fitness and racket sports.'
            ]
        },
        clubs: {
            title: 'CLUBS',
            text: [
                'Partner with RFX to bring our innovative fitness program to your club. Increase member engagement, attract new clients, and offer something truly unique in the fitness industry.',
                'Our team will help you implement RFX programs seamlessly into your existing schedule with full training and support.'
            ]
        }
    };

    joinOptions.forEach((option, index) => {
        option.addEventListener('click', () => {
            // Remove active class from all options
            joinOptions.forEach(opt => opt.classList.remove('active'));
            // Add active class to clicked option
            option.classList.add('active');

            // Get tab key based on index
            const tabKeys = ['coaches', 'player', 'clubs'];
            const key = tabKeys[index];
            const content = tabContent[key];

            // Update content with animation
            if (joinContent && content) {
                joinContent.style.opacity = '0';
                setTimeout(() => {
                    joinContent.innerHTML = `
                        <p>${content.text[0]}</p>
                        <p>${content.text[1]}</p>
                        <a href="#" class="btn btn-primary">Join</a>
                    `;
                    joinContent.style.opacity = '1';
                }, 200);
            }
        });
    });

    // Intersection Observer for Animations
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.1
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, observerOptions);

    // Observe elements for animation
    document.querySelectorAll('.feature-card, .structure-item, .testimonial-card').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });

    // Add animation class styles
    const style = document.createElement('style');
    style.textContent = `
        .animate-in {
            opacity: 1 !important;
            transform: translateY(0) !important;
        }
    `;
    document.head.appendChild(style);

    // Active Navigation Link on Scroll
    const sections = document.querySelectorAll('section[id]');
    const navLinksAll = document.querySelectorAll('.nav-links a');

    window.addEventListener('scroll', () => {
        let current = '';
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            if (scrollY >= sectionTop - 200) {
                current = section.getAttribute('id');
            }
        });

        navLinksAll.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === `#${current}`) {
                link.classList.add('active');
            }
        });
    });

    // Duplicate marquee content for seamless loop
    const marqueeContents = document.querySelectorAll('.marquee-content');
    marqueeContents.forEach(content => {
        const clone = content.innerHTML;
        content.innerHTML = clone + clone;
    });
});

/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ['./content/**/*.{html,js}', './layouts/*.html', './layouts/**/*.{html, js}'],
    theme: {
        fontSize: {
            xs: ['12px', '16px'],
            sm: ['14px', '20px'],
            base: ['16px', '19.5px'],
            lg: ['18px', '21.94px'],
            xl: ['20px', '24.38px'],
            '2xl': ['22px', '29.26px'],
            '3xl': ['28px', '50px'],
            '4xl': ['48px', '58px'],
            '5xl': ['56px', '80px'],
            '8xl': ['88px', '106px'],
            '9xl': ['108px', '120px'],
        },
        extend: {
            lineHeight: {
                narrow: '1.1em',
                /* brauche ich das ? */
            },
            fontFamily: {
                poppins: ['Poppins', 'sans-serif'],
                roboto: ['Roboto', 'sans-serif'],
                robotoMono: ['Roboto-Mono', 'sans-serif'],
            },
            colors: {
                base: '#ffffff',
                'base-offset': '#eaeaea',
                highlight: '#7b16ff',
                heading: '#1c1b1d', 
                text: '#4e5157',
                dot: '#7b16ff'
            },
            /* was brquche ich davon wirklich ?? */
            /*boxShadow: {
                '3xl': '0 10px 40px rgba(0, 0, 0, 0.1)',
            },
            backgroundImage: {
                hero: "url('/images/collection-background.svg')",
                card: "url('/images/thumbnail-background.svg')",
            },*/
            screens: {
                sm: '640px', // Mobile landscape
                md: '768px', // Tablets
                lg: '1024px', // Small laptops
                wide: '1440px', // Desktop
            },
            maxWidth: {
                'wrapper': '1000px',
                'content': '800px'
            },
            animation: {
                'fadeInTop': 'fadeInTop 0.5s ease forwards'
            }
            /*animation: {
                marquee: 'marquee 40s linear infinite',
            },
            keyframes: {
                marquee: {
                    '0%': { transform: 'translateX(0)' },
                    '100%': { transform: 'translateX(-100%)' },
                },
            },*/
        },
    },
    plugins: [],
};

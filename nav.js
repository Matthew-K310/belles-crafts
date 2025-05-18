class SpecialNav extends HTMLElement {
  connectedCallback() {
    this.innerHTML = `
<div class="nav-wrapper">
  <nav>
    <style>
      body {
        margin: 0;
      }

      .nav-wrapper {
        width: 100%;
        position: sticky;
        top: 0;
        z-index: 1000;
      }

      nav {
        background: #907aa9;
        color: white;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 3%; /* Reduced from 5% to 3% */
        border-bottom: 2px solid white;
      }

      .nav-container {
        display: flex;
        align-items: center;
        width: 100%;
        max-width: 1200px; /* Optional: prevents stretching on very wide screens */
        margin: 0 auto;
      }

      .logo {
        display: flex;
        align-items: center;
        margin-right: 0px; /* Adds a bit of space between logo and nav items */
      }

      .header-logo {
        height: 50px;
        max-width: 100px;
        object-fit: contain;
      }

      nav ul {
        display: flex;
        justify-content: center;
        align-items: center;
        list-style: none;
        margin: 0;
        padding: 0;
        flex-grow: 1;
        gap: 40px;
      }

      .nav_link {
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .nav_link svg {
        width: 24px;
        height: 24px;
        stroke: white;
      }

      .nav_link a {
        color: white;
        text-decoration: none;
        font-size: 1.1rem;
        font-weight: 500;
        position: relative;
        transition: color 0.3s ease;
      }

      /* Underline Effect */
      .nav_link a::after {
        content: '';
        position: absolute;
        bottom: -4px;
        left: 0;
        width: 0;
        height: 2px;
        background-color: white;
        transition: width 0.2s ease-in-out;
      }

      .nav_link a:hover::after,
      .nav_link a.active::after {
        width: 100%;
      }

      /* Responsive Design */
      @media (max-width: 768px) {
        nav {
          flex-direction: column;
          padding: 10px;
        }

        .nav-container {
          flex-direction: column;
          align-items: center;
        }

        .logo {
          margin-right: 0;
          margin-bottom: 10px;
        }

        nav ul {
          margin-top: 10px;
          gap: 20px;
        }

        .nav_link svg {
          width: 20px;
          height: 20px;
        }

        .nav_link a {
          font-size: 1rem;
        }
      }
    </style>

    <div class="nav-container">
      <div class="logo">
        <img class="header-logo" alt="Belle's Crafts Logo" src="assets/belle-logo.svg">
      </div>
      <ul>
        <li class="nav_link">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M5 12l-2 0l9 -9l9 9l-2 0"></path>
            <path d="M5 12v7a2 2 0 0 0 2 2h10a2 2 0 0 0 2 -2v-7"></path>
            <path d="M9 21v-6a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v6"></path>
          </svg>
          <a id="homelink" href="index.html">Home</a>
        </li>
        <li class="nav_link">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M3 9a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v9a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-9z"></path>
            <path d="M8 7v-2a2 2 0 0 1 2 -2h4a2 2 0 0 1 2 2v2"></path>
          </svg>
          <a id="shoplink" href="shop.html">Shop</a>
        </li>
        <li class="nav_link">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0"></path>
            <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2"></path>
          </svg>
          <a id="aboutlink" href="about.html">About</a>
        </li>
        <li class="nav_link">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M3 7a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v10a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-10z"></path>
            <path d="M3 7l9 6l9 -6"></path>
          </svg>
          <a href="mailto:bellescrafts06@gmail.com">Contact</a>
        </li>
      </ul>
    </div>
  </nav>
</div>
`;

    // Existing JavaScript remains the same
    let currentPage = decodeURIComponent(window.location.pathname)
      .split("/")
      .filter(Boolean)
      .pop();

    let links = this.querySelectorAll(".nav_link a");

    links.forEach((link) => {
      let linkHref = link.getAttribute("href");

      if (currentPage && linkHref && linkHref.endsWith(currentPage)) {
        link.classList.add("active");
      }
    });
  }
}

customElements.define("special-nav", SpecialNav);

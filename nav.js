class SpecialNav extends HTMLElement {
  connectedCallback() {
    this.innerHTML = `
<div class="nav-wrapper">
	<nav>
		<style>

/* In-site links formatting */
body {
	margin: 0; /* Removes default margin */
}

.nav-wrapper {
	display: flex;
	justify-content: center; /* Centers the nav horizontally */
	align-items: center; /* Centers it vertically (optional) */
	width: 100%; /* Ensures it spans full width */
	position: relative; /* Keeps positioning intact */
	overflow: visible;
	position: sticky;
	top: 0; /* Ensures it sticks to the top */
}

nav {
	background: #907aa9;
	color: white;
	font-weight: normal;
	padding-top: 10px;
	padding-bottom: 5px;
	align-content: center;
	text-align: center;
	gap: 10px;
	top: 0; /* Ensures it sticks to the top */
	width: 100%; /* Ensures full width */
	/* max-width: 600px; /* Limits max width */ 
	border-bottom: 2px solid white;
}

nav ul {
	display: flex; /* Keeps items in a single row */
	justify-content: center; /* Centers items horizontally */
	align-items: center; /* Aligns items vertically */
	flex-wrap: nowrap; /* Prevents wrapping */
	padding: 0;
	margin: 0;
	gap: 50px; /* Adds space between items */
	padding-bottom: 10px;
}

nav ul li {
	display: flex;
	align-items: center; /* Ensures text and icons are aligned */
	gap: 0.5px; /* Reduce space between icon and text */
	padding-right: 5px;
	padding-left: 5px;
	white-space: nowrap; /* Prevents text from breaking */
}

nav ul li a {
	/*font-size: 18px;*/
	font-weight: normal;
	color: rgba(255, 255, 255, 1);
	text-decoration: none;
	font-weight: bold;
}

/* Default font size */
nav ul li a {
	font-size: 1.2rem; /* Normal desktop size */
	/*font-weight: normal;*/
	font-weight: normal;
}

nav ul li svg {
	width: 24px;
	height: 24px;
	max-width: 24px;
	max-height: 24px;
	/*margin-left: 3px;*/
	margin-right: 5px;
	/*gap: 10px;*/
}

.nav_link {
	position: relative; /* Ensure the container is a reference point */
	display: flex;
	align-items: center;
	gap: 3px; /* Adjust space between icon and text */
}

.nav_link a {
	position: relative;
	display: inline-block;
	color: white;
	text-decoration: none;
	/*font-weight: bolder;*/
	font-weight: regular;
}

/* Underline Effect */
.nav_link a::after {
	content: '';
	position: absolute;
	bottom: -4px; /* Adjust distance from text */
	left: 0;
	width: 0%; /* Initially hidden */
	height: 2px;
	background-color: white;
	opacity: 0;
	transition: width 0.2s ease-in-out, opacity 0.3s ease-in-out;
}

/* Hover and Focus Effect */
.nav_link a:hover::after,
.nav_link a:focus::after {
	width: 100%; /* Expand fully */
	opacity: 1;
}

/* Active Link Effect */
.nav_link a.active::after {
	width: 100%;
	opacity: 1;
	background-color: white; /* Ensure underline is visible */
}

/* Responsive Scaling: Keeps it in a row but reduces spacing on smaller screens */
@media (max-width: 768px) {

	nav ul {
		gap: 40px; 
	}

	nav ul li svg {
		width: 18px;
		height: 18px;
	}

	nav ul li a {
		font-size: 0.85rem; /* Adjust for readability */
	}

	.nav_link {
		gap: 1px; /* Slightly reduce spacing */
	}

	section {
		color: white;
	}

	h2 {
		border-bottom: 4px solid rgba(60, 110, 80, 1);
		padding-bottom: 10px;
	}

	label {
		margin: 10px 0 5px;
	}

</style>
		<div class="nav-container">
			<ul>
				<!--Home Nav Button-->
				<li class="nav_link">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
						stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" width="36" height="36"
						viewBox="0 0 36 36" stroke-width="2" style="--darkreader-inline-stroke: currentColor;"
						data-darkreader-inline-stroke="">
						<path d="M5 12l-2 0l9 -9l9 9l-2 0"></path>
						<path d="M5 12v7a2 2 0 0 0 2 2h10a2 2 0 0 0 2 -2v-7"></path>
						<path d="M9 21v-6a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v6"></path>
					</svg>
					<a id="homelink" href="index.html">Home</a></li>
				<!--Video Nav Button-->
				<li class="nav_link">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor"
						stroke-linecap="round" stroke-linejoin="round" width="36" height="36" viewBox="0 0 36 36" stroke-width="2"
						style="--darkreader-inline-stroke: currentColor;" data-darkreader-inline-stroke="">
						<path d="M3 9a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v9a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-9z"></path>
						<path d="M8 7v-2a2 2 0 0 1 2 -2h4a2 2 0 0 1 2 2v2"></path>
					</svg>
					<a id="shoplink" href="shop.html">Shop</a></li>
				<!--About Nav Button-->
				<li class="nav_link">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
						stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" width="36" height="36"
						viewBox="0 0 36 36" stroke-width="2" style="--darkreader-inline-stroke: currentColor;"
						data-darkreader-inline-stroke="">
						<path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0"></path>
						<path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2"></path>
					</svg>
					<a id="aboutlink" href="about.html">About</a></li>
				<!--Contact Nav Button-->
				<li class="nav_link">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor"
						stroke-linecap="round" stroke-linejoin="round" width="36" height="36" viewBox="0 0 36 36" stroke-width="2"
						style="--darkreader-inline-stroke: currentColor;" data-darkreader-inline-stroke="">
						<path d="M3 7a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v10a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-10z"></path>
						<path d="M3 7l9 6l9 -6"></path>
					</svg>
					<!--<a id="contactlink" href="contact.html">Contact Me</a></li>-->
					<a href="mailto:bellescrafts06@gmail.com">Contact</a>
			</ul>
		</div>

	</nav>
</div
`;
    // Normalize current page path
    let currentPage = decodeURIComponent(window.location.pathname)
      .split("/")
      .filter(Boolean) // Remove empty strings
      .pop();

    // Select all nav links
    let links = this.querySelectorAll(".nav_link a");

    links.forEach((link) => {
      let linkHref = link.getAttribute("href");

      // Normalize comparison to handle relative and absolute URLs
      if (currentPage && linkHref && linkHref.endsWith(currentPage)) {
        link.classList.add("active");
      }
    });
  }
}

customElements.define("special-nav", SpecialNav);

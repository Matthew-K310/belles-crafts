class SpecialHeader extends HTMLElement {
  connectedCallback() {
    this.innerHTML = `
<style>
.special-header {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	height: 200px;
	width: 80%;
	margin: auto;
	padding: 10px 0 10px;
}

.header-logo {
	/*height: 110%;*/
	/*width: auto;*/
	height: 90%;  /* Ensures proportional scaling */
	width: 100%;   /* Makes it responsive */
	max-width: 180px; /* Prevents it from getting too large */
}

/* Mobile Styles */
@media (max-width: 768px) {
	.special-header {
		width: 90%; /* Slightly more width for mobile */
		height: auto; /* Allow height to be more flexible */
		padding: 10px 0;
	}

	.header-logo {
		height: auto;
		width: 80%; /* Adjust to fit smaller screens */
		max-width: 150px; /* Prevent it from being too large */
	}
}
</style>

<div class="special-header">
	<img class="header-logo" alt="Belle's Crafts Logo" src="assets/belle-logo.svg"
</div>`;
  }
}

class SpecialFooter extends HTMLElement {
  connectedCallback() {
    this.innerHTML = `
<style>
.special-footer {
	display: flex;
	font-size: 10px;
	align-items: center;
	justify-content: center;
	text-align: center;
	padding: 10px 0;
	width: 100 %;
	margin: auto;
}

/* Mobile Styles */
@media(max-width: 768px) {
	.special-footer {
		font-size: 9px; /* Slightly smaller for mobile */
		padding: 8px 0;
	}
}
</style>

<div class="special-footer">
	<p>&copy; 2025 Belle's Crafts.</p>
</div>
`;
  }
}

customElements.define("special-header", SpecialHeader);
customElements.define("special-footer", SpecialFooter);

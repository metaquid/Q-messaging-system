import { q } from "../../declarations/q";

document.querySelector("form").addEventListener("submit", async (e) => {
	e.preventDefault();
	const button = e.target.querySelector("button");

	const message = document.getElementById("message").value.toString();
	
	const channel = document.getElementById("channel").value.toString();

	button.setAttribute("disabled", true);

	// Interact with foo actor, calling the news method
	const news = await q.news(channel, message);

	button.removeAttribute("disabled");

	document.getElementById("news").innerText = news;

	document.getElementById("message").value = "";

	return false;
});

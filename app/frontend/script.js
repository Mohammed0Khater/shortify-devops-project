async function shortenUrl() {
    const urlInput = document.getElementById('urlInput');
    const resultP = document.getElementById('result');
    const response = await fetch('/api/shorten', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ url: urlInput.value })
    });
    const data = await response.json();
    if (data.short_url) {
        resultP.innerHTML = `Short URL: <a href="${data.short_url}" target="_blank">${data.short_url}</a>`;
    } else {
        resultP.innerHTML = `Error: ${data.error}`;
    }
}

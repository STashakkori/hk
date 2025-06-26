<style>
  body {
      font-family: sans-serif;
      background-color: black;
      color: cyan;
      text-align: center;
  }
  
  input[type="text"] {
      background-color: black;
      color: cyan;
      border: 1px solid magenta;
      padding: 5px 10px;
      cursor: pointer;
  }
  
  button {
      background-color: black;
      color: cyan;
      border: 1px solid cyan;
      padding: 5px 10px;
      cursor: pointer;
  }
</style>hk&gt; pri <input id="input" type="text"> <button onclick="encryptAndDownload()"> \n </button>
<script>
  async function encryptAndDownload() {
      const inputText = document.getElementById('input').value;
      if (!inputText) {
          alert('Enter private hk');
          return;
      }
      if (inputText.includes("hkname.org")) {
          alert("hkname.org is reserved :]");
          return;
      }
      const key = await crypto.subtle.generateKey({
              name: 'AES-GCM',
              length: 256
          }, true, ['encrypt', 'decrypt']),
          iv = crypto.getRandomValues(new Uint8Array(12)),
          encoder = new TextEncoder(),
          data = encoder.encode(inputText),
          encryptedData = await crypto.subtle.encrypt({
              name: 'AES-GCM',
              iv
          }, key, data),
          keyData = await crypto.subtle.exportKey('raw', key),
          fullOutput = new Uint8Array(iv.length + encryptedData.byteLength);
      fullOutput.set(iv);
      fullOutput.set(new Uint8Array(encryptedData), iv.length);
      const hackerName = Array.from(new Uint8Array(keyData)).map(b => b.toString(36)).join('').slice(0, 7);
      download(new Blob([fullOutput]), 'encrypted.txt');
      download(new Blob([keyData]), hackerName + '-key.bin');
      alert('pub hkname: ' + hackerName);
  }
  
  function download(blob, filename) {
      const a = document.createElement('a');
      a.href = URL.createObjectURL(blob);
      a.download = filename;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
  }
</script>

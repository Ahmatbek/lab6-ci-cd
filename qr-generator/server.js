const express = require("express");
const QRCode = require("qrcode");

const app = express();
const PORT = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const HTML = `
<!DOCTYPE html>
<html>
<head>
<title>QR Generator</title>
</head>
<body>

<h1>QR Code Generator</h1>

<form action="/generate" method="POST">
<input type="text" name="text" placeholder="Enter text" required>
<button type="submit">Generate QR</button>
</form>

</body>
</html>
`;

app.get("/", (req,res)=>{
    res.send(HTML);
});

app.post("/generate", async (req,res)=>{

    const text=req.body.text;

    try{

        const qr=await QRCode.toDataURL(text);

        res.send(`
        ${HTML}
        <img src="${qr}">
        <br>
        <a href="${qr}" download="qrcode.png">Download</a>
        `);

    }catch(err){
        res.status(500).send("Error generating QR");
    }

});

app.listen(PORT,()=>{
    console.log("Server running on http://localhost:"+PORT);
});


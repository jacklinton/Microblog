var msg = document.getElementById("secret")
var msgv = document.getElementById("secret").value
var img = document.getElementById("memeImg")
var iurl = document.getElementById("memeUrl")
var imgurl = document.getElementById("memeImg")

iurl.addEventListener("change", function(){
	img = document.getElementById("memeUrl").value
	document.getElementById("memeImg").setAttribute("src", img)
})

msg.addEventListener("change", function(){
	msgv = document.getElementById("secret").value
	return msgv
})

msg.addEventListener("change", function(){
	document.getElementById("body").setAttribute("value", steg.encode(msgv, imgurl))
})
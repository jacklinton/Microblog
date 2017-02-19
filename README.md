The purpose of this activity is the create a microblog running from a Sinatra based sql server.

“…the dreaded Isla de Muerta. It’s an island that cannot be found, except by those who already know where it is.” —Jack Sparrow 


The key concept is “hiding in plain sight.”

The properties of this blog that I will attempt to implement may include the following:

- a ‘post your favorite Meme of the day’ theme
- allowing the users to join groups protected by passwords i.e. the groups will be invite only
- randomly generated, unique meme images as posts
	- encryption of messages based on groups using javascript libraries
	- hiding the encrypted messages in the randomly generated meme images with steganographic .js libraries
- encrypted and hidden messages can be revealed by people in their respective groups
- all encryption and decryption will happen at the client
	- no openly encrypted data will be transferred to or from the server/client
	-nor will there be any openly encrypted data or keys stored in the database
- users can sort messages to only show the ones in their group
- all encrypted material will be concealed on the server i.e. there will be no obviously or visibly encrypted data stored server side
- all encryption/decryption will be done on the client end, and no openly encrypted data will be transmitted to or from the server
- guest users will still be able to post their favorite memes
- make the site and its hidden data as secure and as possible
- alter meme images before deploying to create “white noise” for added uniqueness and to additionally conceal the hidden data
- the nature of the site as a place for sending hidden messages will be as ambiguous as possible
- any other features that will add to the safety and pseudonymity of the users who are passing messages to each other.
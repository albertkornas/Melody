# cmpsc475-albertkornas

# Melody

Melody is an audio streaming platform app available on iPhone. It utilizes the Apple Music API to give the user access to millions of songs.
<img src="https://user-images.githubusercontent.com/26030830/99919639-af4e9980-2cec-11eb-807a-52b02a855900.jpg" width="250">

## Usage
1. Log in to the sandbox Apple ID by navigating to Settings -> Apple ID (the top section in settings) -> Sign Out, then sign in using the  following credentials:
    1. Username: auk7@psu.edu
    1. Password: CS473melody
1. Open the Apple 'Music' app and ensure it contains the following playlists:
    1. <img src="https://user-images.githubusercontent.com/26030830/99919882-1882dc80-2cee-11eb-9e42-fd9478b6c2a7.jpg" width="250">
1. Open the 'Melody' app. You should land on the 'Welcome' screen
    1. <img src="https://user-images.githubusercontent.com/26030830/99919639-af4e9980-2cec-11eb-807a-52b02a855900.jpg" width="250">
1. Tap 'Sign In' to navigate to the home screen, which contains the first playlist found in Apple Music: 'Easy Rock'
    1. <img src="https://user-images.githubusercontent.com/26030830/99919642-b1b0f380-2cec-11eb-82cc-06c31fed8490.jpg" width="250">
1. To open a playlist, tap on any of the album artworks displayed in the scrolling view of the playlist.
    1. <img src="https://user-images.githubusercontent.com/26030830/99919644-b37ab700-2cec-11eb-8252-a27cecd0e7a5.jpg" width="250">
1. To play a song, tap on any of the rows in the song list. The respective song should begin playing. Tap on the row again to pause the song.
1. You may use the navigation bar to navigate back and forth between views.

## Troubleshooting

Due to the sensitive nature of the Apple Music API, you may run into issues unknown to me. 

One of the issues I ran into after switching to the sandbox PSU Apple ID is 'Authentication Failed' when the app attempts to connect to the Apple Music API. When the API makes a request, it uses two keys to authenticate you. One of these is the 'Music-User-Token', which Apple states is used for "personalized requests". I have confirmed that this token does change between Apple Music accounts, but I have no way of knowing if it changes between devices. I have hardcoded the 'Music-User-Token' into one of the app's models. 

Every time the home screen loads, the correct 3-line 'Music-User-Token' is printed in the debug console. **(I understand we shouldn't have debug statements, but this is the best method I could come up with for this possible issue)**

If you are receiving this error after tapping 'Sign In' on the welcome screen, you must edit the Music-User-Token:
<im src="https://user-images.githubusercontent.com/26030830/99920367-fd659c00-2cf0-11eb-9f15-73c8be9e3501.png" width="700">

You can easily fix this issue by *replacing* the musicToken variable located in MelodyModel.swift with the 3-line token printed in the debug console:
<img src="https://user-images.githubusercontent.com/26030830/99920267-554fd300-2cf0-11eb-8ecd-38c54ced58e4.png" width="700">

Restart the app and you should now successfully be able to view the playlists. I am planning to squash this possible bug by asynchronously generating the 'devToken' and then the 'Music-User-Token', so that I don't need to hardcode it in the next version. (This will be done before the final submission)


Another issue I ran into while testing was that once in a blue moon, a song would refuse to play after tapping it. I researched this issue and it seems to be an issue on Apple's end (?). The issue can be resolved by restarting the app.


I have done my best to isolate bugs and provide a product that will smoothly function as intended, but unknown issues are likely to exist. If you find yourself facing catastrophic issues, please text or call me at (484)-904-3581 and I will do my best to fix the issue or provide clearer instructions in a timely manner.

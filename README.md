## iOS_BitCoinWatcher
#iOS app written in Swift to get latest BTC price in USD. UI is not the most complex, but the point of this project is to make API calls asynchronously. We don't want to lock the UI, do we?...

...No, we don't want to that and we probably never will because our response is so small, but still. 

**Key features and swift basics:**
* Multi-thread - using async()
* API call to CoinBase
* Parse response to model struct
* Navigation bar button

<p align="center">
<img src="https://github.com/sebastianoberg/iOS_BitCoinWatcher/blob/main/Screenshots/BitCoinPrice.png" width="300">
</p>
<p align="center">
<img src="https://github.com/sebastianoberg/iOS_BitCoinWatcher/blob/main/Screenshots/No%20internet%20connection.png" width="300">
</p>

# refetcher
Real Estate Fetcher -- conglomerates information for a single real estate property.

# what does it do?
- [X] nothing yet
- [X] this shouldn't be a checklist
- [X] returns last deed number from TXR given taxid

# what it should do
- [ ] get single or multiple property id from user input
- [ ] get text & images from tax records (TXR)
- [ ] get deed pdf from county records (DEED)
- [ ] get text & images from mls listings (MLS)
- [ ] get text & images from mls public records (MLSPUB)
- [ ] get images via ?screenshot? from GIS (GIS)
- [ ] search function for property owner, address, etc

# Connections
* TXR 
    * inputs: parcel id integer only 0000000000000 (13 digits, no special char)
    * returns: deed document number, owner, street address...
* DEED 
    * inputs: deed document number
* MLS 
    * inputs: parcel id integer only 0000000000000 (13 digits, no special char)
* MLSPUB
    * inputs: parcel id integer only 0000000000000 (13 digits, no special char)
    * returns: 
* GIS
    * inputs: parcel id grouping 000-00000-0-0000 (13 digits, seperated by dashes 333-55555-1-4444 )
    * returns: n/a
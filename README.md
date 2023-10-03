# ButterflyApp

# CoreData-Powered Purchase Order App
This iOS application is designed to manage purchase orders and related data using CoreData as the local database. It offers seamless synchronization with a remote server to ensure up-to-date information while providing the ability to add and modify data locally.

# Project Overview

**Data Source:** The app fetches a list of purchase orders from a JSON API endpoint here.
**CoreData Database:** The CoreData database includes four tables: Purchase Order, Item, Invoice, and Receipt, matching the schema of the sample JSON data.
**User Interface:** The app's user interface consists of:
  **Home Page:** Displays a list of purchase orders with details such as PO ID, the number of items, and the last updated date.
  **Detail Page:** Allows users to view the items (item ID and quantity) and invoices (invoice number and received status) for a selected purchase order.
  **Add Purchase Order:** Provides a simple interface to add a new purchase order.
  **Add Item:** Allows users to add new items to an existing purchase order.

# Key Features
**Data Synchronization:** The app initially populates its CoreData database from the server. Local data persists across sessions and is only updated if the server's data has a more recent last updated time.

**User-Friendly UI:** While UI aesthetics were not the primary focus, the app maintains a straightforward and functional user interface.

# Getting Started

Clone this repository to your local machine.
Open the Xcode project and build the app.
Run the app on your iOS simulator or device.

# Contributing
Contributions and improvements to the project are welcome! Please follow our Contribution Guidelines to get started.

# License
This project is licensed under the MIT License.

# Author
Julien K/Nell

Below is some basic UI of the actual app

Project sample
![Simulator Screen Shot - iPhone 12 - 2022-11-29 at 13 51 41](https://user-images.githubusercontent.com/25380694/204496894-8ae85062-b087-4c69-bcaf-6b83844de4a0.png)
![Simulator Screen Shot - iPhone 12 - 2022-11-29 at 13 51 52](https://user-images.githubusercontent.com/25380694/204496949-aadd57b2-fd59-47bb-aa78-96f766bfb47c.png)
![Simulator Screen Shot - iPhone 12 - 2022-11-29 at 13 52 00](https://user-images.githubusercontent.com/25380694/204496961-de1e275f-be4d-4940-a946-15c29ed1dca3.png)
![Simulator Screen Shot - iPhone 12 - 2022-11-29 at 13 52 08](https://user-images.githubusercontent.com/25380694/204496971-b306ee97-f95d-4e55-9e3c-0af61fbe6004.png)

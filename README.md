# CatBreedsApp
IOS application that fetches a list of cats from an API endpoint and displays it in a list

Thank you for the opportunity to do the IOS coding assessment for Egeniq. I enjoyed making the cat breeds app. 

This app uses a simple MVVM architechture. The BreedsViewModel updates the UI bu fetching the data. Network call happens in CatService that coforms to the The APIService protocol. The service is injected onto the viewmodel using constructor injection.  

Since it was a requirement to use up tp date IOS UI practices I have used the latest available features and I have not focused on making it backwards compatible. ex.AsyncImage(IOS 15+) to download url images in ImageView for SwiftUI.

I wanted to unit test the Views, this is not straight forward in SwiftUI and I tried exploring the "ViewInspector" framework to try and attempt this but I did not have enough time.

I tried implementing the refresh control for reloading data, This caused some debug warnings in related to the progress view and refresh control loading at the same time. I did not have enough time to fix this. 

The app does not use any third party dependencies. 





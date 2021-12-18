# CLEAN(VIP) Architecture

## Helpful resources 
[6 Part Medium Artical Explainination](https://medium.com/@mlukacs_42903/spacexodyssey-implement-clean-swift-architecture-vip-with-a-simple-ios-app-fa4a513eb51c)

[Uncle bob explination](http://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## Responsability Flow Diagram
![image](https://user-images.githubusercontent.com/31580350/146651206-a536d12b-9264-4f55-91ce-4bbc646733c7.png)


## Definiations

### Interactor 
The role of the interactor is mainly the computation part of a scene. This is where you would fetch data (network or local),
detect errors, make calculations, compute entries.

### Worker
The worker is a secondary element in the clean swift schema. Its main role has to do with the heavy lifting and unburdening of the interactor from things like network api calls, database requests and so on.

A worker is less intrinsically linked to a scene. It can be a global element connected to several interactors.

### Presenter
The presenter has a very precise role. Its main focus is to create a representation of parts of the data to be displayed on screen at a specific moment in time. This data representation is contained in an element called the viewmodel. Once it has formatted the raw data the presenter sends it back to the controller to be displayed.

We could describe the presenter as the designer of the clean swift scene.

To follow our example, the presenter would transform all our raw data into displayable information. Dates or numbers would be transformed into string at this stage to be easily displayed by the controller and complex models would be stripped of any unnecessary information.

### Model 
This component encapsulates the request, response and viewmodel representation for each flow of action of the scene. 
These 3 elements are of the structure type.

### Router 
This element is linked to the controller. It takes care of the transition between scenes (screen of an application).
It is also responsible for transferring the correct data between the different parts of the application.

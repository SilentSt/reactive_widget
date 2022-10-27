## 0.1.0

first version of the library

## 0.1.1

* removed widget field from wm
* you have no need to pass ``ReactiveWidgetModel`` and ``Stream`` to ``ReactiveWidget``
* instead using ``stream`` you need to use ```wm.controller``` in your ```ReactiveWidget```
* now you need just call your ```ReactiveWidget``` contructor to use it

## 0.2.0

* now you have no need to send ```ReactiveWidgetModel``` to ```ReactiveWidgetConstructor```, instead you need to initialize your ```ReactiveWidgetModel``` in special method ```widgetModelBuilder``` in ```ReactiveWidget```
* now you have context in ```ReactiveWidgetModel``` to call dialogs and so on when you need
* now you need to create methods in ```ReactiveWidgetModel``` and call them from your ```ReactiveWidget``` as ```wm.someMethod```
* now you need to set your content builder in special method in ```ReactiveWidget```
* if you need to get reactive data you need to get ```data``` in ```contentBuilde```

## 0.2.1

* removed provider
* add initial actions

## 0.2.2

* add custom stream setUp

## 0.2.3

* removed custom stream, instead you can add listener to remote stream which will put value to local stream
* add docs

# 0.2.4

* fixed wm not disposed
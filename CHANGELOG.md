## 0.1.0

first version of the library

## 0.1.1

* removed widget field from wm
* you have no need to pass ``ReactiveWidgetModel`` and ``Stream`` to ``ReactiveWidget``
* instead using ``stream`` you need to use ```wm.controller``` in your ```ReactiveWidget```
* now you need just call your ```ReactiveWidget``` contructor to use it
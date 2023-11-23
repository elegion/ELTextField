# ``ELTextField/ELDefaultTextFieldBehavior``

## Overview

Текущий класс реализует базовое Поведение для обработки событий.

Для работы с библиотекой достаточно использовать текущий класс или наследоваться от него, так как под капотом реализует методы протокола ``ELTextInputDelegate``. Переопределять методы можно, если стоит подобная задача.

## Topics

### Создание поведения

Конструктор принимает все значения протокола ``ELTextFieldBehavior``
- ``init(text:textMapper:placeholder:placeholderMapper:isEditable:rightItem:mask:traits:validation:)``

### *ELTextFieldBehavior*

- ``mask``
- ``traits``
- ``validation``
- ``placeholder``
- ``value``
- ``isValid``
- ``onAction``
- ``containerDelegate``
- ``configure(textInput:)``
- ``updateState(_:)``
- ``updateText(_:)``

### *ELTextInputDelegate*

- ``textInputShouldClear(_:)``
- ``textInputShouldBeginEditing(_:)``
- ``textInputDidBeginEditing(_:)``
- ``textInputdDidEndEditing(_:)``
- ``textInput(_:shouldChangeCharactersIn:replacementString:)``
- ``textInputShouldReturn(_:)``
- ``textInput(_:canPerformAction:withSender:)``

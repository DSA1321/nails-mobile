﻿&НаКлиенте
Процедура Зарегистрироваться(Команда)
	Если ЭтаФорма.Логин = "" Тогда
		Сообщить("Введите логин пользователя!");
		Возврат;
	ИначеЕсли Этаформа.Телефон = "" Тогда
		Сообщить("Введите телефон пользователя!");
		Возврат;
	КонецЕсли;
	АутентификацияРегистрацияАвторизация.ВыполнитьРегистрацию(Логин, Телефон);
	ЭтаФорма.Закрыть();
	ЗавершитьРаботуСистемы(Ложь, Истина);
	ОткрытьФорму("Обработка.ЗаписьКлиентовНаУслугу.Форма.Форма");
КонецПроцедуры

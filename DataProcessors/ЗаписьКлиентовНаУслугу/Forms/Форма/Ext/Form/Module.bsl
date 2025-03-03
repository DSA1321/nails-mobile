﻿&НаСервере
Процедура ЗаписатьсяНаСервере()
	ЗаписьКлиента = Документы.ЗаписьКлиента.СоздатьДокумент();
	ЗаписьКлиента.Дата = НачалоМинуты(Объект.ДатаЗаписи);
	ЗаписьКлиента.Сотрудник = Объект.Сотрудник;
	СтрокаУслуги = ЗаписьКлиента.Услуги.Добавить();
	СтрокаУслуги.Услуга = Объект.Услуга;
	СтрокаУслуги.Стоимость = ЭтаФорма.Стоимость;
	СтруктураРеквизитовДокумента = Новый Структура;
	СтруктураРеквизитовДокумента.Вставить("ДатаЗаписи", Объект.ДатаЗаписи);
	СтруктураРеквизитовДокумента.Вставить("Сотрудник", Строка(Объект.Сотрудник));
	СтруктураРеквизитовДокумента.Вставить("GUIDПользователя", ПараметрыСеанса.ТекущийПользователь.ВнешнийGUID);
	МассивУслуг = Новый Массив;
	Услуга = Новый Структура;
	Услуга.Вставить("Услуга", Строка(Объект.Услуга));
	Услуга.Вставить("Цена", ЭтаФорма.Стоимость);
	Услуга.Вставить("Количество", 1);
	Услуга.Вставить("Сумма", ЭтаФорма.Стоимость);
	МассивУслуг.Добавить(Услуга);
	СтруктураРеквизитовДокумента.Вставить("МассивУслуг", МассивУслуг);
	СтруктураРеквизитовДокументаJSON = ОбменСОсновнойБазой.ПолучитьТекстJSON(СтруктураРеквизитовДокумента);
	ДокументУспешноОтправлен = ОбменСОсновнойБазой.ОтправитьЗаписьВЦентральнуюБазу(СтруктураРеквизитовДокументаJSON);
	Если ДокументУспешноОтправлен Тогда        
		ЗаписьКлиента.Записать(РежимЗаписиДокумента.Проведение);
		СообщениеПользователю = Новый СообщениеПользователю;
		СообщениеПользователю.Текст = СтрШаблон("Вы записаны на услугу %1 к мастеру %2 на дату %3",                                                
		Объект.Услуга, Объект.Сотрудник, Формат(Объект.ДатаЗаписи, "ДФ='dd.MM.yyyy HH:mm'"));                                    
		СообщениеПользователю.Сообщить();
		Объект.ДатаЗаписи = '00010101';
		Объект.Сотрудник = Справочники.Сотрудники.ПустаяСсылка();
		Объект.Услуга = Справочники.Услуги.ПустаяСсылка();
		ЭтаФорма.Стоимость = 0;
	Иначе    
		СообщениеПользователю = Новый СообщениеПользователю;
		СообщениеПользователю.Текст = "Не удалось отправить Запись!";
		СообщениеПользователю.Сообщить();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Записаться(Команда)
	ЗаписатьсяНаСервере();
	ЭтаФорма.Закрыть();
	ОткрытьФорму("Документ.ЗаписьКлиента.ФормаСписка");
КонецПроцедуры

&НаСервере
Процедура УслугаПриИзмененииНаСервере()
	Этаформа.Стоимость = Объект.Услуга.Стоимость;
КонецПроцедуры

&НаКлиенте
Процедура УслугаПриИзменении(Элемент)
	УслугаПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ДатаЗаписиПриИзменении(Элемент)
	Если Объект.ДатаЗаписи <= (НачалоДня(ТекущаяДата()) - 1) Тогда
		СообщениеПользователю = Новый СообщениеПользователю;
		СообщениеПользователю.Текст = "Указаная дата не может быть меньше текущей";
		СообщениеПользователю.Сообщить();
		Объект.ДатаЗаписи = '00010101';
		Возврат;
	КонецЕсли;
КонецПроцедуры

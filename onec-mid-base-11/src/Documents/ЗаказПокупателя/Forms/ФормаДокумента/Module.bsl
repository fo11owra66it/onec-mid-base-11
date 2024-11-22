
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// +++ Телицин С.Л.: homework-11-2-1 (Добавление ревезита формы "Контактное Лицо")
	ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво();
	// --- Телицин С.Л.: homework-11-2-1 (Добавление ревезита формы "Контактное Лицо")
	
	// +++ Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)
	ДобавитьГруппаЭлементовСогласованнаяСкидкаВГруппаШапкаЛево();
	// --- Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)
		
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	// +++ Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)
	КоэффициентСкидки = 1 - (ТекущиеДанные.Скидка + Объект.ДЗ_СогласованнаяСкидка) / 100;
	
	Если КоэффициентСкидки <= 0 Тогда
		ТекущиеДанные.Сумма = 0;
		//@skip-check bsl-legacy-check-dynamic-feature-access
		ТекстСообщения = СтрШаблон("Скидка равна или превышает %1 в строке №%2. %3.", "100%", ТекущиеДанные.НомерСтроки, ТекущиеДанные.Номенклатура);
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
	Иначе
		ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	КонецЕсли;
	
	РассчитатьСуммуДокумента();
	// --- Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)
	
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	
КонецПроцедуры
 
&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры

&НаКлиенте
Асинх Процедура ДЗ_ЗадатьВопросОПересчетеСкидки()
	
	// +++ Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)
    Режим = РежимДиалогаВопрос.ДаНет;
    Ответ = Ждать ВопросАсинх(НСтр("ru = 'Изменен процент скидки. Пересчитать таблицы товаров и услуг?';"), Режим, 0);
	
    Если Ответ = КодВозвратаДиалога.Нет Тогда
        Возврат;
	КонецЕсли;
	
	ДЗ_ПересчитатьСкидкуТчТоварыИУслуги();
	// --- Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)

КонецПроцедуры

//@skip-check module-unused-method
&НаКлиенте
Процедура ДЗ_ПересчитатьСкидку(Команда)
	
	// +++ Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»
	ДЗ_ПересчитатьСкидкуТчТоварыИУслуги();
	// --- Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область ПрограммныйИнтерфейс

&НаКлиенте
Процедура ДЗ_СогласованнаяСкидкаПриИзменении(Элемент)
	
	// +++ Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»
	Если Не ЗначениеЗаполнено(Объект.Товары) И Не ЗначениеЗаполнено(Объект.Услуги) Тогда 
		Возврат;
	КонецЕсли;
	
	ДЗ_ЗадатьВопросОПересчетеСкидки(); 
	// --- Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)
	
КонецПроцедуры

&НаКлиенте
Процедура ДЗ_ПересчитатьСкидкуТчТоварыИУслуги()
	
	// +++ Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»
	Для Каждого СтрТч Из Объект.Товары Цикл		
		РассчитатьСуммуСтроки(СтрТч);	
	КонецЦикла;

	Для Каждого СтрТч Из Объект.Услуги Цикл	
		РассчитатьСуммуСтроки(СтрТч);	
	КонецЦикла;
	// --- Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво()
	
	// +++ Телицин С.Л.: homework-11-2-1 (Добавление ревезита формы "Контактное Лицо")
	ПолеВвода = Элементы.Добавить("КонтактноеЛицо", Тип("ПолеФормы"), Элементы.ГруппаШапкаПраво);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ДЗ_КонтактноеЛицо";
    // --- Телицин С.Л.: homework-11-2-1 (Добавление ревезита формы "Контактное Лицо")
    
КонецПроцедуры

&НаСервере
Процедура ДобавитьГруппаЭлементовСогласованнаяСкидкаВГруппаШапкаЛево()
	
	// +++ Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)
	ГруппаСогласованнаяСкидка						= Элементы.Добавить("ГруппаСкидка", Тип("ГруппаФормы"), Элементы.ГруппаШапкаЛево);
	ГруппаСогласованнаяСкидка.Вид				 	= ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаСогласованнаяСкидка.ОтображатьЗаголовок	= ЛОЖЬ; 
	ГруппаСогласованнаяСкидка.Группировка			= ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	
	ПолеВвода = Элементы.Добавить("СогласованнаяСкидка", Тип("ПолеФормы"), ГруппаСогласованнаяСкидка);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ДЗ_СогласованнаяСкидка";
	ПолеВвода.УстановитьДействие("ПриИзменении", "ДЗ_СогласованнаяСкидкаПриИзменении");
	
	Команда = Команды.Добавить("ПересчитатьСкидку");
	Команда.Заголовок = "Пересчитать скидку";
	Команда.Действие = "ДЗ_ПересчитатьСкидку";
	
	КнопкаФормы = Элементы.Добавить("ПересчитатьСкидку", Тип("КнопкаФормы"), ГруппаСогласованнаяСкидка);
	КнопкаФормы.ИмяКоманды = "ПересчитатьСкидку";
	КнопкаФормы.Вид 		= ВидКнопкиФормы.ОбычнаяКнопка;
	КнопкаФормы.Картинка	= БиблиотекаКартинок.Обновить;
	КнопкаФормы.Отображение = ОтображениеКнопки.КартинкаИТекст;	
    // --- Телицин С.Л.: homework-11-2-2 (Добавление поля «Согласованная скидка»)
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти


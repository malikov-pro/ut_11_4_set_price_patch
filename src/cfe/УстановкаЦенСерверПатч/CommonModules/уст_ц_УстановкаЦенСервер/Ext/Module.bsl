﻿Функция РассчитатьДокументУстановкаЦенНоменклатуры(обУстановкаЦенНоменклатуры) Экспорт
	
	Если Ложь Тогда
		обУстановкаЦенНоменклатуры = Документы.УстановкаЦенНоменклатуры.СоздатьДокумент();	
	КонецЕсли;
	
	
	ЗаполнитьОбъектУстановкаЦенНоменклатуры(обУстановкаЦенНоменклатуры);
	
	Форма = Новый Структура;
	Форма.Вставить("УникальныйИдентификатор", Новый УникальныйИдентификатор);
	
	ЗаполнитьШапкуДокументаУстановкаЦенНоменклатуры(Форма, обУстановкаЦенНоменклатуры);
	
	УстановкаЦенСервер.ИнициализироватьВыбранныеЦены(Форма);
	
	
	ДанныеДляРасчетаВычисляемыхЦенНаКлиенте = ЗаполнитьДокумент(обУстановкаЦенНоменклатуры, Форма);
	Если ДанныеДляРасчетаВычисляемыхЦенНаКлиенте <> Неопределено Тогда
		АдресХранилищаДанныхДляРасчетаВычисляемыхЦенНаКлиенте = ПоместитьВоВременноеХранилище(
		ДанныеДляРасчетаВычисляемыхЦенНаКлиенте,
		Форма.УникальныйИдентификатор);
	КонецЕсли;
	
	//---
	
	ПараметрыРасчета = ПолучитьПараметрыРасчета(обУстановкаЦенНоменклатуры.ВидыЦен.ВыгрузитьКолонку("ВидЦены"));
	
	ДанныеДляРасчетаВычисляемыхЦенНаКлиенте = УстановкаЦенСервер.РассчитатьЦены(Форма, ПараметрыРасчета);
	
	Если ДанныеДляРасчетаВычисляемыхЦенНаКлиенте <> Неопределено Тогда
		РассчитатьВычисляемыеЦены(Форма, ДанныеДляРасчетаВычисляемыхЦенНаКлиенте);
	КонецЕсли;
	
	УстановкаЦенСервер.ПоместитьВидыЦенВТабличнуюЧасть(Форма, обУстановкаЦенНоменклатуры.ВидыЦен, Истина);
	
	Данные = Новый Структура;
	Данные.Вставить("Форма", Форма);
	Данные.Вставить("Документы", Новый Массив);
	Данные.Вставить("СохранятьБазовые", Ложь);
	Данные.Документы.Добавить(обУстановкаЦенНоменклатуры);
	УстановкаЦенСервер.ПоместитьЦеныВТабличнуюЧасть(Данные);
	
КонецФункции

Функция ПолучитьПараметрыРасчета(МассивВидовЦен)
	
	Результат = Новый Структура();
	Результат.Вставить("ЗагрузкаСтарыхЦен",      Ложь);
	Результат.Вставить("ОкруглениеРучныхЦен",    Ложь);
	Результат.Вставить("ВидыЦен",                МассивВидовЦен);
	Результат.Вставить("ТолькоВыделенныеСтроки", Ложь);
	Результат.Вставить("ТолькоНезаполненные",    Ложь);
	
	Возврат Результат; 
		
КонецФункции


Функция ПолучитьВыбранныеЦены()
	
	ВыбранныеЦены = Новый ТаблицаЗначений;
	ВыбранныеЦены.Колонки.Добавить("Ссылка", Новый ОписаниеТипов("СправочникСсылка.ВидыЦен"));
	ВыбранныеЦены.Колонки.Добавить("СпособЗаданияЦены", Новый ОписаниеТипов("ПеречислениеСсылка.СпособыЗаданияЦен"));
	ВыбранныеЦены.Колонки.Добавить("Выбрана", Новый ОписаниеТипов("Булево"));
	ВыбранныеЦены.Колонки.Добавить("Зависит", Новый ОписаниеТипов("Булево"));
	ВыбранныеЦены.Колонки.Добавить("Влияет", Новый ОписаниеТипов("Булево"));
	ВыбранныеЦены.Колонки.Добавить("ВлияющиеЦены", Новый ОписаниеТипов("СписокЗначений"));
	ВыбранныеЦены.Колонки.Добавить("ЗависимыеЦены", Новый ОписаниеТипов("СписокЗначений"));
	ВыбранныеЦены.Колонки.Добавить("Уровень", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(10));
	ВыбранныеЦены.Колонки.Добавить("Валюта", Новый ОписаниеТипов("СправочникСсылка.Валюты"));
	ВыбранныеЦены.Колонки.Добавить("РеквизитДопУпорядочивания", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(5));
	ВыбранныеЦены.Колонки.Добавить("Идентификатор", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(50));
	ВыбранныеЦены.Колонки.Добавить("Зависимый", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(0));
	ВыбранныеЦены.Колонки.Добавить("Наименование", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(0));
	ВыбранныеЦены.Колонки.Добавить("ИмяКолонки", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(0));
	ВыбранныеЦены.Колонки.Добавить("ЦеновыеГруппы", Новый ОписаниеТипов("ТаблицаЗначений"));
	ВыбранныеЦены.Колонки.Добавить("Формула", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(0));
	ВыбранныеЦены.Колонки.Добавить("ПорогСрабатывания", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(15, 2));
	ВыбранныеЦены.Колонки.Добавить("ПорогиСрабатывания", Новый ОписаниеТипов("ТаблицаЗначений"));
	ВыбранныеЦены.Колонки.Добавить("ВлияющиеВидыЦен", Новый ОписаниеТипов("ТаблицаЗначений"));
	ВыбранныеЦены.Колонки.Добавить("ПравилаОкругленияЦены", Новый ОписаниеТипов("ТаблицаЗначений"));
	ВыбранныеЦены.Колонки.Добавить("ОкруглятьВБольшуюСторону", Новый ОписаниеТипов("Булево"));
	ВыбранныеЦены.Колонки.Добавить("АдресСхемыКомпоновкиДанных", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(0));
	ВыбранныеЦены.Колонки.Добавить("НайденыОбязательныеПараметры", Новый ОписаниеТипов("Булево"));
	ВыбранныеЦены.Колонки.Добавить("Параметры", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(0));
	ВыбранныеЦены.Колонки.Добавить("ЗапрещенныйВидЦены", Новый ОписаниеТипов("Булево"));
	ВыбранныеЦены.Колонки.Добавить("АдресНастроекСхемыКомпоновкиДанных", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(0));
	ВыбранныеЦены.Колонки.Добавить("БазовыйВидЦены", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(0));
	ВыбранныеЦены.Колонки.Добавить("Наценка", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(10, 2));
	ВыбранныеЦены.Колонки.Добавить("УстанавливатьЦенуПриВводеНаОсновании", Новый ОписаниеТипов("Булево"));
	ВыбранныеЦены.Колонки.Добавить("ПометкаУдаления", Новый ОписаниеТипов("Булево"));
	ВыбранныеЦены.Колонки.Добавить("ВариантОкругления", Новый ОписаниеТипов("ПеречислениеСсылка.ВариантыОкругления"));
	
	Возврат ВыбранныеЦены;
	
КонецФункции

Функция ПолучитьДеревоЦен()
	
	ДеревоЦен = Новый  ДеревоЗначений;
	ДеревоЦен.Колонки.Добавить("Номенклатура", Новый ОписаниеТипов("СправочникСсылка.Номенклатура"));
	ДеревоЦен.Колонки.Добавить("Характеристика", Новый ОписаниеТипов("СправочникСсылка.ХарактеристикиНоменклатуры"));
	ДеревоЦен.Колонки.Добавить("ИндексКартинки", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(1, 0));
	ДеревоЦен.Колонки.Добавить("ЕдиницаИзмерения", Новый ОписаниеТипов("СправочникСсылка.УпаковкиЕдиницыИзмерения"));
	ДеревоЦен.Колонки.Добавить("ЦеноваяГруппа", Новый ОписаниеТипов("СправочникСсылка.ЦеновыеГруппы"));
	ДеревоЦен.Колонки.Добавить("ХарактеристикиИспользуются", Новый ОписаниеТипов("Булево"));
	ДеревоЦен.Колонки.Добавить("РеквизитСортировки", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(10, 0));
	ДеревоЦен.Колонки.Добавить("Артикул", Новый ОписаниеТипов(Метаданные.ОпределяемыеТипы.Артикул.Тип.Типы()));
	
	Возврат ДеревоЦен;
	
КонецФункции

Функция ПолучитьТаблицаПриемник(ИмяТаблицы)
	
	ТаблицаЗначений =  Новый ТаблицаЗначений;
	
	Если ИмяТаблицы = "ПорогиСрабатывания" Тогда
		
		ТаблицаЗначений.Колонки.Добавить("ЦеноваяГруппа", Новый ОписаниеТипов("СправочникСсылка.ЦеновыеГруппы"));
		ТаблицаЗначений.Колонки.Добавить("ПорогСрабатывания", Новый ОписаниеТипов(Метаданные.ОпределяемыеТипы.ДенежнаяСуммаНеотрицательная.Тип.Типы()));
		
	ИначеЕсли ИмяТаблицы = "ПравилаОкругленияЦены" Тогда
		
		ТаблицаЗначений.Колонки.Добавить("НижняяГраницаДиапазонаЦен", Новый ОписаниеТипов(Метаданные.ОпределяемыеТипы.ДенежнаяСуммаНеотрицательная.Тип.Типы()));
		ТаблицаЗначений.Колонки.Добавить("ТочностьОкругления", Новый ОписаниеТипов(Метаданные.ОпределяемыеТипы.ДенежнаяСуммаНеотрицательная.Тип.Типы()));
		ТаблицаЗначений.Колонки.Добавить("ПсихологическоеОкругление", Новый ОписаниеТипов(Метаданные.ОпределяемыеТипы.ДенежнаяСуммаНеотрицательная.Тип.Типы()));
		
	ИначеЕсли ИмяТаблицы = "ЦеновыеГруппы" Тогда
		
		ТаблицаЗначений.Колонки.Добавить("ЦеноваяГруппа", Новый ОписаниеТипов("СправочникСсылка.ЦеновыеГруппы"));
		ТаблицаЗначений.Колонки.Добавить("Формула", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(0));
		ТаблицаЗначений.Колонки.Добавить("БазовыйВидЦены", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповСтроки(0));
		ТаблицаЗначений.Колонки.Добавить("Наценка", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(10, 2));
		
	ИначеЕсли ИмяТаблицы = "ВлияющиеВидыЦен" Тогда
		
		ТаблицаЗначений.Колонки.Добавить("ВлияющийВидЦены", Новый ОписаниеТипов("СправочникСсылка.ВидыЦен"));
		
	КонецЕсли;
	
	Возврат ТаблицаЗначений;
	
	
КонецФункции

Процедура ЗаполнитьШапкуДокументаУстановкаЦенНоменклатуры(Форма, обУстановкаЦенНоменклатуры)
	
	Форма.Вставить("Объект", обУстановкаЦенНоменклатуры);
	Форма.Вставить("Модифицированность", Ложь);
	Форма.Вставить("ВыбранныеЦены", ПолучитьВыбранныеЦены());
	
	
	Форма.Вставить("ОтображатьВлияющиеЦены", Ложь);
	
	
	Форма.Вставить("АдресХранилищаПараметровСхемКомпоновкиПоВидамЦен", Неопределено);
	Форма.Вставить("АдресХранилищаНастройкиКомпоновкиДанных", Неопределено);
	
	//--
	
	Форма.Вставить("ДеревоЦен", ПолучитьДеревоЦен());
	Форма.Вставить("ВыбранныеЦеныИзменены", Ложь);
	Форма.Вставить("РассчитыватьАвтоматически", Истина);
	
	//-- ПриСозданииНаСервере
	Форма.Вставить("КодФормы", "УстановкаЦенНоменклатуры");
	
	
	Форма.Вставить("ИспользоватьЦеновыеГруппы", ПолучитьФункциональнуюОпцию("ИспользоватьЦеновыеГруппы"));
	Форма.Вставить("ИспользоватьХарактеристикиНоменклатуры", ПолучитьФункциональнуюОпцию("ИспользоватьХарактеристикиНоменклатуры"));
	Форма.Вставить("ИспользоватьУпаковкиНоменклатуры", ПолучитьФункциональнуюОпцию("ИспользоватьУпаковкиНоменклатуры"));
	Форма.Вставить("ИспользоватьНесколькоВидовЦен", ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВидовЦен"));
	
КонецПроцедуры

Процедура ЗаполнитьОбъектУстановкаЦенНоменклатуры(обУстановкаЦенНоменклатуры)
	
	обУстановкаЦенНоменклатуры.Дата = ТекущаяДата();
	
	НомерВПределахДня = УстановкаЦенВызовСервера.РассчитатьНомерВПределахДня(обУстановкаЦенНоменклатуры.Дата, обУстановкаЦенНоменклатуры.Ссылка);
	обУстановкаЦенНоменклатуры.Дата = УстановкаЦенКлиентСервер.РассчитатьДатуДокумента(обУстановкаЦенНоменклатуры.Дата, НомерВПределахДня);
	обУстановкаЦенНоменклатуры.Согласован = Истина;
	обУстановкаЦенНоменклатуры.Статус = Перечисления.СтатусыУстановокЦенНоменклатуры.Согласован;
	обУстановкаЦенНоменклатуры.ПометкаУдаления = Ложь;
	
КонецПроцедуры

Процедура ЗаполнитьТаблицуЗначенийИзТаблицыЗначений(ТаблицаПриемник, ТаблицаИсточник, ИмяТаблицы) Экспорт
	
	ТаблицаПриемник = ПолучитьТаблицаПриемник(ИмяТаблицы);
	
	Для каждого СтрИст Из ТаблицаИсточник Цикл
		
		СтрПр = ТаблицаПриемник.Добавить();
		ЗаполнитьЗначенияСвойств(СтрПр, СтрИст);
		
	КонецЦикла;
	
КонецПроцедуры


//-- Форма документа УстановкаЦенНоменклатуры

Функция ЗаполнитьДокумент(Объект, ЭтаФорма)
	
	ИспользоватьНесколькоВидовЦен = ЭтаФорма.ИспользоватьНесколькоВидовЦен;
	ВыбранныеЦены = ЭтаФорма.ВыбранныеЦены;
	
	//--
	
	КэшДанных = УстановкаЦенСервер.ИнициализироватьСтруктуруКэшаДанных();
	
	ДанныеДляРасчетаВычисляемыхЦенНаКлиенте = Неопределено;
	
	Если Объект.ВидыЦен.Количество() > 0 
		ИЛИ Объект.Товары.Количество() > 0 
		ИЛИ НЕ ИспользоватьНесколькоВидовЦен ИЛИ ВыбранныеЦены.Количество() = 1 Тогда
		
		Если УстановкаЦенКлиентСервер.ВыбранныеСтрокиТаблицыВидовЦен(ЭтаФорма).Количество() > 0 Тогда
			
			УстановкаЦенКлиентСервер.ВыбратьВсеЗависимыеЦены(ЭтаФорма);
			ЗаполнитьТЧВидыЦен(ЭтаФорма, Объект);
			УстановкаЦенСервер.ПостроитьДеревоЦен(ЭтаФорма);
			УстановкаЦенСервер.ЗагрузитьТабличнуюЧастьТовары(ЭтаФорма, КэшДанных);
			УстановкаЦенСервер.ЗагрузитьБазовыеЦены(ЭтаФорма, КэшДанных);
			//Если УстановкаЦенСервер.ЗаполненыОбязательныеПараметрыСхемКомпоновкиДанных(ЭтаФорма, Ложь) Тогда
			//	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаУстановкаЦен;
			//Иначе
			//	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаВидыЦен;
			//КонецЕсли;
		Иначе
			
			Если НЕ ИспользоватьНесколькоВидовЦен Тогда
				Для Каждого ТекСтрока Из ВыбранныеЦены Цикл
					ТекСтрока.Выбрана = Истина;
				КонецЦикла;
			КонецЕсли;

			Если ВыбранныеЦены.Количество() = 1 Тогда
				Для Каждого ТекСтрока Из ВыбранныеЦены Цикл
					ТекСтрока.Выбрана = Истина;
				КонецЦикла;
			КонецЕсли;
			
			// Документ вводится на основании Приобретения товаров и услуг.
			// Необходимо выбрать цены, расчитываемые по документу поступления и переформировать таблицу цен.
			Если ЗначениеЗаполнено(Объект.ДокументОснование)
				И Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
				
				Для Каждого ТекСтрока Из ВыбранныеЦены Цикл
					Если ТекСтрока.УстанавливатьЦенуПриВводеНаОсновании
						И Не ТекСтрока.ЗапрещенныйВидЦены Тогда
						ТекСтрока.Выбрана = Истина;
						НоваяСтрока = Объект.ВидыЦен.Добавить();
						НоваяСтрока.ВидЦены = ТекСтрока.Ссылка;
					КонецЕсли;
				КонецЦикла;
				
				УстановкаЦенКлиентСервер.ВыбратьВсеЗависимыеЦены(ЭтаФорма);
				УстановкаЦенКлиентСервер.ВыбратьВсеВлияющиеЦены(ЭтаФорма);
				ВыбранныеЦеныИзменены = Ложь;
				
				//--
				Если УстановкаЦенКлиентСервер.ВыбранныеВидыЦен(ЭтаФорма).Количество() > 0 Тогда
					//--
					
					ВидыЗагружаемыхСтарыхЦен = Новый Массив();
					Для Каждого ТекСтрока Из ВыбранныеЦены Цикл
						Если ТекСтрока.Выбрана И (ТекСтрока.СпособЗаданияЦены = Перечисления.СпособыЗаданияЦен.Вручную) Тогда
							ВидыЗагружаемыхСтарыхЦен.Добавить(ТекСтрока);
						КонецЕсли;
					КонецЦикла;
					
					УстановкаЦенКлиентСервер.ВыбратьВсеЗависимыеЦены(ЭтаФорма);
					ЗаполнитьТЧВидыЦен(ЭтаФорма, Объект);
					УстановкаЦенСервер.ПостроитьДеревоЦен(ЭтаФорма);
					УстановкаЦенСервер.ЗагрузитьТабличнуюЧастьТовары(ЭтаФорма, КэшДанных);
					
					УстановкаЦенСервер.ПоместитьВидыЦенВТабличнуюЧасть(ЭтаФорма, Объект.ВидыЦен);
					
					Данные = Новый Структура;
					Данные.Вставить("Форма", ЭтаФорма);
					Данные.Вставить("Документы", Новый Массив);
					Данные.Вставить("СохранятьБазовые", Ложь);
					Данные.Документы.Добавить(Объект);
					УстановкаЦенСервер.ПоместитьЦеныВТабличнуюЧасть(Данные);
					
					УстановкаЦенСервер.ОбновитьСтарыеЦеныНоменклатуры(ЭтаФорма, КэшДанных);
					
					ТаблицаНоменклатуры = УстановкаЦенСервер.СоздатьТаблицуНоменклатурыПоДеревуЦен(ЭтаФорма);
					
					СтруктураПараметров = Новый Структура();
					СтруктураПараметров.Вставить("МассивСтрокВидовЦен", ВидыЗагружаемыхСтарыхЦен);
					СтруктураПараметров.Вставить("ПрименятьОкругление", Ложь);
					
					УстановкаЦенСервер.ЗагрузитьЗначенияБазовыхЦен(
						ЭтаФорма,
						ТаблицаНоменклатуры,
						КэшДанных,
						СтруктураПараметров);
					
					Если УстановкаЦенСервер.ЗаполненыОбязательныеПараметрыСхемКомпоновкиДанных(ЭтаФорма, Ложь) Тогда
						
						УстановкаЦенСервер.ВычислитьЦеныПоДаннымИБ(ЭтаФорма, ТаблицаНоменклатуры,,,КэшДанных);
						
						Если ОбщегоНазначения.РазделениеВключено() Тогда
							ДанныеДляРасчетаВычисляемыхЦенНаКлиенте = УстановкаЦенСервер.ПодготовитьДанныеДляРасчетаВычисляемыхЦен(ЭтаФорма, ТаблицаНоменклатуры, КэшДанных);
						Иначе
							УстановкаЦенСервер.РассчитатьВычисляемыеЦены(ЭтаФорма, ТаблицаНоменклатуры, КэшДанных);
						КонецЕсли;
						
						//Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаУстановкаЦен;
					
					Иначе
						ПроверитьЗаполнениеПараметровПриОткрытии = Истина;
					КонецЕсли;
					
				КонецЕсли;
				
			Иначе
				
				УстановкаЦенКлиентСервер.ВыбратьВсеЗависимыеЦены(ЭтаФорма);
				ЗаполнитьТЧВидыЦен(ЭтаФорма, Объект);
				УстановкаЦенСервер.ПостроитьДеревоЦен(ЭтаФорма);
				УстановкаЦенСервер.ЗагрузитьТабличнуюЧастьТовары(ЭтаФорма, КэшДанных);
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ДанныеДляРасчетаВычисляемыхЦенНаКлиенте;
	
КонецФункции

//-- Общий модуль УстановкаЦенКлиент

Процедура РассчитатьВычисляемыеЦены(Форма, ДанныеДляРасчетаВычисляемыхЦенНаКлиенте) Экспорт
	
	Соответствие = Новый Соответствие;
	
	Для Каждого СтрокаНоменклатура Из Форма.ДеревоЦен.ПолучитьЭлементы() Цикл
		Соответствие.Вставить(
			Строка(СтрокаНоменклатура.Номенклатура.УникальныйИдентификатор()),
			СтрокаНоменклатура);
		Для Каждого СтрокаХарактеристика Из СтрокаНоменклатура.ПолучитьЭлементы() Цикл
			Соответствие.Вставить(
				Строка(СтрокаНоменклатура.Номенклатура.УникальныйИдентификатор())
				+ Строка(СтрокаХарактеристика.Характеристика.УникальныйИдентификатор()),
				СтрокаХарактеристика);
		КонецЦикла;
	КонецЦикла;
	
	РассчитыватьПоФормуламОтДругихВидовЦен = ПредопределенноеЗначение(
		"Перечисление.СпособыЗаданияЦен.РассчитыватьПоФормуламОтДругихВидовЦен");
	НаценкаНаДругойВидЦен = ПредопределенноеЗначение(
		"Перечисление.СпособыЗаданияЦен.НаценкаНаДругойВидЦен");
	
	Для Каждого СтрокаМассива Из ДанныеДляРасчетаВычисляемыхЦенНаКлиенте.СтрокиТаблицыЦен Цикл
		
		Если ЗначениеЗаполнено(СтрокаМассива.Характеристика) Тогда
			Ключ = Строка(СтрокаМассива.Номенклатура.УникальныйИдентификатор())
			     + Строка(СтрокаМассива.Характеристика.УникальныйИдентификатор());
		Иначе
			Ключ = Строка(СтрокаМассива.Номенклатура.УникальныйИдентификатор());
		КонецЕсли;

		СтрокаТаблицыЦен = Соответствие.Получить(Ключ);
		
		СтруктураЦеноваяГруппа = Новый Структура("ЦеноваяГруппа", СтрокаТаблицыЦен.ЦеноваяГруппа);
		
		Для Каждого ВидЦеныСсылка Из ДанныеДляРасчетаВычисляемыхЦенНаКлиенте.ВидыЦен Цикл
			
			ВидЦены = УстановкаЦенКлиентСервер.НайтиСтрокуВидаЦен(Форма.ВыбранныеЦены, ВидЦеныСсылка);
			
			Если ВидЦены.СпособЗаданияЦены = РассчитыватьПоФормуламОтДругихВидовЦен
				ИЛИ ВидЦены.СпособЗаданияЦены = НаценкаНаДругойВидЦен Тогда
				
				Если Не ДанныеДляРасчетаВычисляемыхЦенНаКлиенте.ТолькоНезаполненные Тогда
					СтрокаТаблицыЦен[ВидЦены.ИмяКолонки] = 0;
				КонецЕсли;
				
				ТекущаяЦена = СтрокаТаблицыЦен[ВидЦены.ИмяКолонки];
				Если ТекущаяЦена = 0 Или Не ДанныеДляРасчетаВычисляемыхЦенНаКлиенте.ТолькоНезаполненные Тогда
					
					ЦеновыеГруппыАлгоритмов = ВидЦены.ЦеновыеГруппы.НайтиСтроки(СтруктураЦеноваяГруппа);
					Если ЦеновыеГруппыАлгоритмов.Количество() > 0 Тогда
						Если ВидЦены.СпособЗаданияЦены = РассчитыватьПоФормуламОтДругихВидовЦен Тогда
							Формула = ЦеновыеГруппыАлгоритмов[0].Формула;
						Иначе
							Формула = "["
							        + ЦеновыеГруппыАлгоритмов[0].БазовыйВидЦены
							        + "]*"
							        + Формат((ЦеновыеГруппыАлгоритмов[0].Наценка/100)+1,"ЧРД=.; ЧРГ=' '; ЧГ=0");
						КонецЕсли;
					Иначе
						Если ВидЦены.СпособЗаданияЦены = РассчитыватьПоФормуламОтДругихВидовЦен Тогда
							Формула = ВидЦены.Формула;
						Иначе
							Формула = "[" + ВидЦены.БазовыйВидЦены + "]*" + Формат((ВидЦены.Наценка/100)+1,"ЧРД=.; ЧРГ=' '; ЧГ=0");
						КонецЕсли;
					КонецЕсли;
					
					ЦеновыеГруппыПорогов = ВидЦены.ПорогиСрабатывания.НайтиСтроки(СтруктураЦеноваяГруппа);
					Если ЦеновыеГруппыПорогов.Количество() > 0 Тогда
						ПорогСрабатывания = ЦеновыеГруппыПорогов[0].ПорогСрабатывания;
					Иначе
						ПорогСрабатывания = ВидЦены.ПорогСрабатывания;
					КонецЕсли;
					
					Если ЗначениеЗаполнено(Формула) Тогда
						
						Для Каждого БазоваяЦена Из ВидЦены.ВлияющиеЦены Цикл
							
							СтрокаБазовойЦены = УстановкаЦенКлиентСервер.НайтиСтрокуВидаЦен(
								Форма.ВыбранныеЦены,
								БазоваяЦена.Значение);
							
							СтрокаПересчетаВалюты   = УстановкаЦенКлиентСервер.СтрокаПересчетаВалюты(
								СтрокаБазовойЦены.Валюта,
								ВидЦены.Валюта,
								ДанныеДляРасчетаВычисляемыхЦенНаКлиенте.КурсыВалют);
								
							Если Форма.ИспользоватьУпаковкиНоменклатуры Тогда
								СтрокаПересчетаУпаковок = УстановкаЦенКлиентСервер.СтрокаПересчетаУпаковок(
									СтрокаТаблицыЦен,
									СтрокаБазовойЦены,
									ВидЦены,
									ДанныеДляРасчетаВычисляемыхЦенНаКлиенте.СоответствиеКоэффициентовУпаковокНоменклатуры);
							Иначе
								СтрокаПересчетаУпаковок = "";
							КонецЕсли;
							СтрокаЗамены = " СтрокаТаблицыЦен."
							             + СтрокаБазовойЦены.ИмяКолонки
										 + " " + СтрокаПересчетаУпаковок
										 + СтрокаПересчетаВалюты;
							Формула = СтрЗаменить(Формула, "[" + СтрокаБазовойЦены.Идентификатор + "]", СтрокаЗамены);
							
						КонецЦикла;
						
						Попытка
							
							ЗначениеЦены = УстановкаЦенКлиентСервер.ОкруглитьЦену(Вычислить(Формула), ВидЦены);
							
							СтараяЦена = СтрокаТаблицыЦен["СтараяЦена" + ВидЦены.ИмяКолонки];
							Если СтараяЦена <> 0 Тогда
								ПроцентИзменения = Окр(
									100*(ЗначениеЦены - СтараяЦена)/СтараяЦена,
									5,2);
							Иначе
								ПроцентИзменения = 0;
							КонецЕсли;
							
							Если    ПорогСрабатывания = 0
								ИЛИ СтараяЦена = 0
								ИЛИ ?(ПроцентИзменения > 0, ПроцентИзменения >= ПорогСрабатывания, -ПроцентИзменения >= ПорогСрабатывания) Тогда
								
								СтрокаТаблицыЦен[ВидЦены.ИмяКолонки] = ЗначениеЦены;
								Если СтараяЦена <> 0 Тогда
									СтрокаТаблицыЦен["ПроцентИзменения" + ВидЦены.ИмяКолонки] = ПроцентИзменения;
								Иначе
									СтрокаТаблицыЦен["ПроцентИзменения" + ВидЦены.ИмяКолонки] = 0;
								КонецЕсли;
								
							Иначе
								СтрокаТаблицыЦен[ВидЦены.ИмяКолонки] = СтараяЦена;
								СтрокаТаблицыЦен["ПроцентИзменения" + ВидЦены.ИмяКолонки] = 0;
							КонецЕсли;
							
							СтрокаТаблицыЦен["СуммаИзменения"   + ВидЦены.ИмяКолонки] = СтрокаТаблицыЦен[ВидЦены.ИмяКолонки] - СтрокаТаблицыЦен["СтараяЦена" + ВидЦены.ИмяКолонки];
							
							СтрокаТаблицыЦен["ИзмененаВручную" + ВидЦены.ИмяКолонки]       = Ложь;
							СтрокаТаблицыЦен["ИзмененаАвтоматически" + ВидЦены.ИмяКолонки] = Истина;
							
						Исключение
							
							Если ЗначениеЗаполнено(СтрокаТаблицыЦен.Характеристика) Тогда
								ТекстСообщения = НСтр("ru='Для номенклатуры ""%Номенклатура%"" с характеристикой ""%Характеристика%""
								                          |не рассчитана цена по виду цен ""%ВидЦены%"" 
								                          |по причине: %ОписаниеОшибки%'");
							Иначе
								ТекстСообщения = НСтр("ru='Для номенклатуры ""%Номенклатура%"" не рассчитана цена 
								                          |по виду цен ""%ВидЦены%""
								                          |по причине: %ОписаниеОшибки%'");
							КонецЕсли;
							
							ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ВидЦены%"       , ВидЦены.Ссылка);
							ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Номенклатура%"  , СтрокаТаблицыЦен.Номенклатура);
							ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Характеристика%", СтрокаТаблицыЦен.Характеристика);
							ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОписаниеОшибки%", КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
						
							ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
								ТекстСообщения,
								Форма.Объект.Ссылка,
								"ДеревоЦен");
							
						КонецПопытки;
						
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьТЧВидыЦен(ЭтаФорма, Объект)
	
	Для Каждого СтрВЦ Из ЭтаФорма.ВыбранныеЦены Цикл
		
		Если СтрВЦ.Выбрана Тогда
			
			ПараметрыОтбора = Новый Структура();
			ПараметрыОтбора.Вставить("ВидЦены", СтрВЦ.Ссылка);
			нСтроки = Объект.ВидыЦен.НайтиСтроки(ПараметрыОтбора);
			
			Если нСтроки.Количество() = 0 Тогда
				СтрТЧВЦ = Объект.ВидыЦен.Добавить();
				СтрТЧВЦ.ВидЦены = СтрВЦ.Ссылка; 
			КонецЕсли;
			
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

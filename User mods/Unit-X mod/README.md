# [Unit-X mod]
## Краткое содержание
Этом мод позволяет подключить сушику iDryer X (которая на arduino nano) как второй микроконтроллер к iDryer Unut
![img1](https://github.com/user-attachments/assets/64693cec-fa60-4c0a-a4d9-ead2b9fab13b)

## Руководство
1. ### Меняем оптопару moc3023 на moc3063 (обязательно!)
![2025-03-17 16 55 45](https://github.com/user-attachments/assets/89123318-d57d-4415-9af9-94d5fb4ae864)


2. ### Загрузчик arduino
   ### ВАЖНО: Если arduino уже прошивалась прошивкой iDryer X, на нее нужно загрузить загрузчик, если нет переходите к следующему пункту.
* Делается это так: в arduino ide выбераем плата: arduino nano / программатор: USBasp / записать загрузчик
   ![Снимок экрана 2025-03-17 в 17 20 17](https://github.com/user-attachments/assets/e9c90d9f-bf44-4221-aa0f-b61343050e36)


3. ### Собираем прошивку для arduino nano   
* Подключаемся по SSH к Rpi 
* Первым устанавливаем пакет компиляции AVR ``` sudo apt install gcc-avr avr-libc avrdude binutils-avr ```
* Собрать прошивку проще всего через KIAUH  
   Если kiauh не устоновлено   ``` sudo apt-get update && sudo apt-get install git -y cd ~ && git clone https://github.com/dw-0/kiauh.git ```

* ``` ./kiauh/kiauh.sh  ```
  
* Advanced     
  ![Снимок экрана 2025-03-17 в 15 56 17](https://github.com/user-attachments/assets/e8245b6b-e84f-442b-bf40-f4d4e15e1ff3)
* Build + Flash            
  ![Снимок экрана 2025-03-17 в 17 46 19](https://github.com/user-attachments/assets/ae9dd135-2f53-4a5c-817b-507552eb1263)
* Поставте все как у меня и нажмине клавишу Q       
  ![Снимок экрана 2025-03-17 в 15 47 53](https://github.com/user-attachments/assets/903672db-571f-43fc-835d-39e836446643)              
  ![Снимок экрана 2025-03-17 в 15 48 00](https://github.com/user-attachments/assets/9e98375c-f021-486a-a3c2-d0a5947e7512)
* Regular flashing method      
  ![Снимок экрана 2025-03-17 в 16 09 31](https://github.com/user-attachments/assets/baec0df1-4717-4c33-b021-5ca211f4b3cd)
* make flash (default)      
  ![Снимок экрана 2025-03-17 в 16 09 41](https://github.com/user-attachments/assets/c82b8f80-8f4a-41b6-a653-78cb296627f9)
* USB      
  ![Снимок экрана 2025-03-17 в 16 09 53](https://github.com/user-attachments/assets/3a827992-caa3-4213-a041-945f31fa3cdf)
* И выберети порт к которому подключена arduino. В моем случае 0    
  ![Снимок экрана 2025-03-17 в 16 10 06](https://github.com/user-attachments/assets/8ee0638d-4aae-47b7-b25e-2ef95f2a456a)

  Если что-то не получилось при сборку, я прилогаю файл hex который можно прошить программатором, но лучше так не делать;)               

4. ### Конфигурация
* Добовляем в конфиг файл Unit_X.cfg
* В файле iDryer.cfg [include Unit-X.cfg]              
  ![include](https://github.com/user-attachments/assets/6f42c62f-f609-4229-89ec-55c0de3e982c)
* В файле Unit_X.cfg путь устройства меняем на свой              
  ![serial](https://github.com/user-attachments/assets/9f0be9d8-0076-4924-86c9-9a59576b2bd7)
* 




  

 

import 'package:flutter/material.dart';

class UserAgreementScreen extends StatelessWidget {
  const UserAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Соглашение'),
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: Center(
        child: ListView(
          children: [
            Text(
                '''Соглашение на обработку персональных данных Сервисом ПАПАФИТНЕС
Присоединяясь к настоящему Соглашению и оставляя свои данные в Сервисе ПАПАФИТНЕС, (далее – Сервис), путем заполнения полей онлайн-заявки (регистрации) в мобильном приложении Пользователь:
 • подтверждает, что указанные им персональные данные принадлежат лично ему;
 • признает и подтверждает, что он внимательно и в полном объеме ознакомился с настоящим Соглашением и содержащимися в нем условиями обработки его персональных данных, указываемых им в полях он-лайн заявки (регистрации) в приложении;
 • признает и подтверждает, что все положения настоящего Соглашения и условия обработки его персональных данных ему понятны;
 • дает согласие на обработку Сервисом предоставляемых персональных данных в целях регистрации Пользователя в Сервисе, а также на передачу его персональных данных той организации (спортивному сооружению, фитнес-клубу, школе танцев, студии и т.д.), в мобильном приложении которой он регистрируется;
 • выражает согласие с условиями обработки персональных данных без каких-либо оговорок и ограничений.

Пользователь дает свое согласие на обработку его персональных данных, а именно совершение действий, предусмотренных п. 3 ч. 1 ст. 3 Федерального закона от 27.07.2006 N 152-ФЗ "О персональных данных", и подтверждает, что, давая такое согласие, он действует свободно, своей волей и в своем интересе.

Согласие Пользователя на обработку персональных данных является конкретным, информированным и сознательным.
Настоящее согласие Пользователя применяется в отношении обработки следующих персональных данных:
 • фамилия, имя, отчество;
 • пол, дата рождения;
 • место пребывания (город, область);
 • номера телефонов;
 • адреса электронной почты (E-mail);
 • иные данные, предусмотренные он-лайн заявкой (регистрацией) в мобильном приложении.

Пользователь, предоставляет Сервису право осуществлять следующие действия (операции) с персональными данными:
 • сбор и накопление;
 • хранение в течение установленных нормативными документами сроков хранения отчетности, но не менее трех лет, с момента даты прекращения пользования услуг Сервиса Пользователем;
 • уточнение (обновление, изменение);
 • использование в целях регистрации Пользователя в Сервисе;
 • уничтожение;
 • передача по требованию суда, в т.ч. третьим лицам, с соблюдением мер, обеспечивающих защиту персональных данных от несанкционированного доступа.

Указанное согласие действует бессрочно с момента предоставления данных и может быть отозвано Вами путем подачи заявления администрации Сервиса с указанием данных, определенных ст. 14 Закона «О персональных данных». 
Отзыв согласия на обработку персональных данных может быть осуществлен путем направления Пользователем соответствующего распоряжения в простой письменной форме на адрес электронной почты (E-mail) support@mobifitness.ru. 
Сервис не несет ответственности за использование (как правомерное, так и неправомерное) третьими лицами информации, размещенной Пользователем в Сервисе, включая её воспроизведение и распространение, осуществленные всеми возможными способами. 
Сервис имеет право вносить изменения в настоящее Соглашение. При внесении изменений в актуальной редакции указывается дата последнего обновления. Новая редакция Соглашения вступает в силу с момента ее размещения, если иное не предусмотрено новой редакцией Соглашения. 

К настоящему Соглашению и отношениям между пользователем и Сервисом, возникающим в связи с применением Соглашения подлежит применению материальное и процессуальное право Российской Федерации. 
Сбор данных о Пользователе из социальных сетей 
В целях оптимизации работы сервиса и взаимодействия с Пользователем Сервис вправе собирать указанные в настоящем разделе данные о Пользователе из социальных сетей:
 • facebook.com* (иноагент)
 • иные системы размещения персональных данных при наличии ссылки на это в данном Соглашении.
 • Сбор данных о Пользователе из системы facebook.com* (Признаны иноагентом)

В случае, если регистрация Пользователя в Сервисе по собственному желанию Пользователя осуществляется через социальный сервис facebook.com* (Признаны иноагентом), Сервис собирает следующие сведения о Пользователе из системы facebook.com* (Признаны иноагентом):
 • имя и фамилия Пользователя, а также его никнейм;
 • пол Пользователя;
 • место пребывания (город, населенный пункт).''', style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
    );
  }
}

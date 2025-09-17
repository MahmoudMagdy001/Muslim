class PrayerTimesResponse {
  PrayerTimesResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PrayerTimesResponse.fromJson(Map<String, dynamic> json) =>
      PrayerTimesResponse(
        code: json['code'],
        status: json['status'],
        data: PrayerData.fromJson(json['data']),
      );
  final int code;
  final String status;
  final PrayerData data;

  Map<String, dynamic> toJson() => {
    'code': code,
    'status': status,
    'data': data.toJson(),
  };
}

class PrayerData {
  PrayerData({required this.timings, required this.date, required this.meta});

  factory PrayerData.fromJson(Map<String, dynamic> json) => PrayerData(
    timings: Timings.fromJson(json['timings']),
    date: DateInfo.fromJson(json['date']),
    meta: Meta.fromJson(json['meta']),
  );
  final Timings timings;
  final DateInfo date;
  final Meta meta;

  Map<String, dynamic> toJson() => {
    'timings': timings.toJson(),
    'date': date.toJson(),
    'meta': meta.toJson(),
  };
}

class Timings {
  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstThird,
    required this.lastThird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
    fajr: json['Fajr'],
    sunrise: json['Sunrise'],
    dhuhr: json['Dhuhr'],
    asr: json['Asr'],
    sunset: json['Sunset'],
    maghrib: json['Maghrib'],
    isha: json['Isha'],
    imsak: json['Imsak'],
    midnight: json['Midnight'],
    firstThird: json['Firstthird'],
    lastThird: json['Lastthird'],
  );

  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstThird;
  final String lastThird;

  Map<String, dynamic> toJson() => {
    'Fajr': fajr,
    'Sunrise': sunrise,
    'Dhuhr': dhuhr,
    'Asr': asr,
    'Sunset': sunset,
    'Maghrib': maghrib,
    'Isha': isha,
    'Imsak': imsak,
    'Midnight': midnight,
    'Firstthird': firstThird,
    'Lastthird': lastThird,
  };

  Map<String, String> toMap() => {
    'Fajr': fajr,
    'Sunrise': sunrise,
    'Dhuhr': dhuhr,
    'Asr': asr,
    'Sunset': sunset,
    'Maghrib': maghrib,
    'Isha': isha,
    'Imsak': imsak,
    'Midnight': midnight,
    'Firstthird': firstThird,
    'Lastthird': lastThird,
  };
}

class DateInfo {
  DateInfo({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory DateInfo.fromJson(Map<String, dynamic> json) => DateInfo(
    readable: json['readable'],
    timestamp: json['timestamp'],
    hijri: Hijri.fromJson(json['hijri']),
    gregorian: Gregorian.fromJson(json['gregorian']),
  );
  final String readable;
  final String timestamp;
  final Hijri hijri;
  final Gregorian gregorian;

  Map<String, dynamic> toJson() => {
    'readable': readable,
    'timestamp': timestamp,
    'hijri': hijri.toJson(),
    'gregorian': gregorian.toJson(),
  };
}

class Hijri {
  Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
    required this.adjustedHolidays,
    required this.method,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
    date: json['date'],
    format: json['format'],
    day: json['day'],
    weekday: Weekday.fromJson(json['weekday']),
    month: Month.fromJson(json['month']),
    year: json['year'],
    designation: Designation.fromJson(json['designation']),
    holidays: List<String>.from(json['holidays']),
    adjustedHolidays: List<String>.from(json['adjustedHolidays']),
    method: json['method'],
  );
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;
  final Designation designation;
  final List<String> holidays;
  final List<String> adjustedHolidays;
  final String method;

  Map<String, dynamic> toJson() => {
    'date': date,
    'format': format,
    'day': day,
    'weekday': weekday.toJson(),
    'month': month.toJson(),
    'year': year,
    'designation': designation.toJson(),
    'holidays': holidays,
    'adjustedHolidays': adjustedHolidays,
    'method': method,
  };
}

class Gregorian {
  Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.lunarSighting,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
    date: json['date'],
    format: json['format'],
    day: json['day'],
    weekday: Weekday.fromJson(json['weekday']),
    month: Month.fromJson(json['month']),
    year: json['year'],
    designation: Designation.fromJson(json['designation']),
    lunarSighting: json['lunarSighting'],
  );
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;
  final Designation designation;
  final bool lunarSighting;

  Map<String, dynamic> toJson() => {
    'date': date,
    'format': format,
    'day': day,
    'weekday': weekday.toJson(),
    'month': month.toJson(),
    'year': year,
    'designation': designation.toJson(),
    'lunarSighting': lunarSighting,
  };
}

class Weekday {
  Weekday({required this.en, this.ar});

  factory Weekday.fromJson(Map<String, dynamic> json) =>
      Weekday(en: json['en'], ar: json['ar']);
  final String en;
  final String? ar;

  Map<String, dynamic> toJson() => {'en': en, 'ar': ar};
}

class Month {
  Month({required this.number, required this.en, this.ar, this.days});

  factory Month.fromJson(Map<String, dynamic> json) => Month(
    number: json['number'],
    en: json['en'],
    ar: json['ar'],
    days: json['days'],
  );
  final int number;
  final String en;
  final String? ar;
  final int? days;

  Map<String, dynamic> toJson() => {
    'number': number,
    'en': en,
    'ar': ar,
    'days': days,
  };
}

class Designation {
  Designation({required this.abbreviated, required this.expanded});

  factory Designation.fromJson(Map<String, dynamic> json) =>
      Designation(abbreviated: json['abbreviated'], expanded: json['expanded']);
  final String abbreviated;
  final String expanded;

  Map<String, dynamic> toJson() => {
    'abbreviated': abbreviated,
    'expanded': expanded,
  };
}

class Meta {
  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    latitude: json['latitude'],
    longitude: json['longitude'],
    timezone: json['timezone'],
    method: Method.fromJson(json['method']),
  );
  final double latitude;
  final double longitude;
  final String timezone;
  final Method method;

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'timezone': timezone,
    'method': method.toJson(),
  };
}

class Method {
  Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  factory Method.fromJson(Map<String, dynamic> json) => Method(
    id: json['id'],
    name: json['name'],
    params: Map<String, dynamic>.from(json['params']),
    location: Location.fromJson(json['location']),
  );
  final int id;
  final String name;
  final Map<String, dynamic> params;
  final Location location;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'params': params,
    'location': location.toJson(),
  };
}

class Location {
  Location({required this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: (json['latitude'] as num).toDouble(),
    longitude: json['longitude'] != null
        ? (json['longitude'] as num).toDouble()
        : null,
  );
  final double latitude;
  final double? longitude;

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };
}

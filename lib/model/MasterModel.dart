class Instructor {
  final int id;
  final String name;
  final String image;

  Instructor({
    required this.id,
    required this.name,
    required this.image,
  });
}

class Projects {
  final int id;
  final String image;
  final String category;
  final String date;
  final String location;
  final String details;
  final List photo;

  Projects({
    required this.id,
    required this.category,
    required this.image,
    required this.date,
    required this.location,
    required this.details,
    required this.photo,
  });
}
class AllProject {
  final int id;
  final String image;
  final String category;
  final String date;
  final String location;
  final String details;
  final List photo;

  AllProject({
    required this.id,
    required this.image,
    required this.category,
    required this.date,
    required this.location,
    required this.details,
    required this.photo,
  });
}

class Course {
  final int id;
  final String nameCourse;
  final String nameInstructor;
  final String images;
  final String price;
  final String rate;
  final String link;
  final String description;
  final String moreDetails;

  Course({
    required this.id,
    required this.nameCourse,
    required this.nameInstructor,
    required this.images,
    required this.price,
    required this.rate,
    required this.link,
    required this.description,
    required this.moreDetails,
  });
}
class AllCourse {
  final int id;
  final String nameCourse;
  final String nameInstructor;
  final String images;
  final String price;
  final String rate;
  final String link;
  final String description;
  final String moreDetails;

  AllCourse({
    required this.id,
    required this.nameCourse,
    required this.nameInstructor,
    required this.images,
    required this.price,
    required this.rate,
    required this.link,
    required this.description,
    required this.moreDetails,
  });
}



class News {
  final String Images;
  final String TextNews;

  News({
    required this.Images,
    required this.TextNews,
  });
}

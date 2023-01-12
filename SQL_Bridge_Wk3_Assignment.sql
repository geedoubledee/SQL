DROP TABLE IF EXISTS _Groups;
DROP TABLE IF EXISTS _Users;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Access;

CREATE TABLE _Groups(
	id int AUTO_INCREMENT PRIMARY KEY,
	_Group varchar(50) NOT NULL UNIQUE
);

INSERT INTO _Groups(_Group)
VALUES
	("I.T."),
    ("Sales"),
    ("Administration"),
    ("Operations");

CREATE TABLE _Users(
	id int AUTO_INCREMENT PRIMARY KEY,
	_User varchar(50) NOT NULL,
	_Group_id int REFERENCES _Groups(id)
);

INSERT INTO _Users(_User, _Group_id)
VALUES
	("Modesto", 1),
	("Ayine", 1),
    ("Christopher", 2),
    ("Cheong woo", 2),
    ("Saulat", 3),
    ("Heidy", NULL);

CREATE TABLE Rooms(
	id int AUTO_INCREMENT PRIMARY KEY,
	Room varchar(50) NOT NULL UNIQUE
);

INSERT INTO Rooms(Room)
VALUES
	("101"),
    ("102"),
    ("Auditorium A"),
    ("Auditorium B");

CREATE TABLE Access(
	Room_id int REFERENCES Rooms(id),
	_Group_id int REFERENCES _Groups(id),
	CONSTRAINT Access_id PRIMARY KEY(Room_id, _Group_id)
);

INSERT INTO Access(Room_id, _Group_id)
VALUES
	(1, 1),
	(2, 1),
    (2, 2),
    (3, 2);

SELECT
_Groups.id AS "Group ID",
_Groups._Group AS "Group",
_Users.id AS "User ID",
_Users._User AS "User"
FROM _Groups
LEFT JOIN _Users
ON _Groups.id = _Users._Group_id
ORDER BY _Groups.id, _Users.id;

SELECT
Rooms.id AS "Room ID",
Rooms.Room AS "Room",
Access._Group_id AS "Group ID",
_Groups._Group AS "Group"
FROM Rooms
LEFT JOIN Access
ON Rooms.id = Access.Room_id
LEFT JOIN _Groups
ON Access._Group_id = _Groups.id
ORDER BY Rooms.id, Access._Group_id;

SELECT
_Users.id AS "User ID",
_Users._User AS "User",
_Users._Group_id AS "Group ID",
_Groups._Group AS "Group",
Access.Room_id AS "Room ID",
Rooms.Room AS "Room"
FROM _Users
LEFT JOIN _Groups
ON _Users._Group_id = _Groups.id
LEFT JOIN Access
ON _Groups.id = Access._Group_id
LEFT JOIN Rooms
ON Access.Room_id = Rooms.id
ORDER BY _Users._User, _Groups._Group, Rooms.Room;
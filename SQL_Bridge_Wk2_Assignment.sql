SELECT
V.id AS "Video_id",
V.Title,
V.Length_Min,
V.URL,
R.id AS "User_id",
R.User,
R.Rating,
R.Review
FROM Videos AS V
INNER JOIN Reviewers AS R
ON V.id = R.Video_id
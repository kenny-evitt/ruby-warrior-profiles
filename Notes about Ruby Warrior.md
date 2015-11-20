# Notes about Ruby Warrior

## Warrior

Does the warrior die if their HP falls to (exactly) 0? YES

## Enemies

| ------------ | -- | -------- | --------- | --------- | ---------- |
|              |    |          |           | Min.      |            |
|              |    |          |           | total     |            |
|              |    | Attacked | Attacking | attacking | Attacking  |
| Enemy        | HP | damage   | damage    | damage    | range      |
| ------------ | -- | -------- | --------- | --------- | ---------- |
| Sludge       | 12 |        5 |         3 |        6  |         0  |
| Thick Sludge | 24 |        5 |         3 |       12  |         0  |
| Archer       |  7 |        5 |         3 |        6+ |         1+ |
| ------------ | -- | -------- | --------- | --------- | ---------- |

Min. total attacking damage assumes that the warrior is initially out of attacking range, that there is only one of that type of enemy in a hypothetical level, and that the warrior is moving forward until attacking (forward).

Values in the form of *x+* imply that the ultimate value is unknown, based on experience alone. Determining that any value *is* known is, of course, based on a number of assumptions, e.g. that enemies always attack if they can.

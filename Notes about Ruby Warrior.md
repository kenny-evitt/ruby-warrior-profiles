# Notes about Ruby Warrior

## Warrior

Does the warrior die if their HP falls to (exactly) 0? YES

## Enemies

| ------------ | -- | -------- | --------- | -------- | --------- | ---------- |
|              |    |          |           |          | Min.      |            |
|              |    |          |           |          | total     |            |
|              |    | Attacked | Attacking | Shooting | attacking | Attacking  |
| Enemy        | HP | damage   | damage    | damage   | damage    | range      |
| ------------ | -- | -------- | --------- | -------- | --------- | ---------- |
| Sludge       | 12 |        5 |         3 |          |        6  |         0  |
| Thick Sludge | 24 |        5 |         3 |          |       12  |         0  |
| Archer       |  7 |        5 |           |        3 |       12  |         2  |
| ------------ | -- | -------- | --------- | -------- | --------- | ---------- |

Min. total attacking damage assumes that the warrior is initially out of attacking range, that there is only one of that type of enemy in a hypothetical level, that the warrior is moving forward until attacking (forward), and that the warrior attacks until killing the enemy.

Values in the form of *x+* imply that the ultimate value is unknown, based on experience alone. Determining that any value *is* known is, of course, based on a number of assumptions, e.g. that enemies always attack if they can.

Assumptions:

 - Enemies always attack the warrior if they can.
 - Enemies never move.
 - Enemies cannot rest (refresh their HP).

## Levels

### Level 6

When playing [the BLOC-hosted version of Ruby Warrior](https://www.bloc.io/ruby-warrior#/), I opted for a strategy of resting until reaching max health. This time, for the Markus beginner profile, I've opted initially to rest until the warrior can survive attacking any (one) enemy, assuming the worst such scenario given the enemies encountered; but only if the warrior isn't currently being attacked.

My problem now is that I want the warrior to retreat, so that it can rest, as needed, if they're being shot at by an archer. But I need to incorporate a longer memory so that the warrior doesn't simply oscillate between walking towards an archer and retreating away from them when the warrior's HP are near the 'minimum HP to survive retreating'.

I'd like to implement a nice way to handle walking and attacking an archer and retreating when needed, but there's no trivial way to determine that the closest enemy *is* an archer.

## Strategy

 - The warrior has to walk onto stairs to pass a level.
 - Scoring:
   - Killing an enemy adds their max health to the score.
   - Rescuing a captive earns 20 points.
   - Passing the level within the bonus time earns the bonut time (turns?) remaining to the score.
   - Defeating all enemies and rescuing all captives adds a 20% overall bonus.
   - For some (possible) levels, it's best to not kill an enemy or rescue a captive, to earn the highest score.

### Fighting Enemies

For each enemy, there is a minimum HP the warrior needs to be able to survive long enough to kill the enemy; without retreating.

Different *configurations* or distributions of enemies may require a different minimum HP.

Assuming that enemies do not move, nor rest (refresh their HP), the warrior should be able to defeat any enemy – that doesn't kill the warrior immediately or before the warrior can attack them at least once – by retreating appropriately.

Retreating is walking to or towards a 'safe' space, i.e. a space from which no enemies can attack the warrior. Note that in some (possible) levels, there is no safe space that can be reached from the warrior's current space.

The warrior should always be capable of surviving a full retreat, i.e. reaching a safe space, so that they can then rest.

#### Fighting Archers

Archers can shoot, and cause damage to the warrior, from a range of 2 spaces, i.e. when there are up to 2 empty spaces between them and the warrior.

The archer will shoot when, on the previous turn, there are two empty spaces between them and the warrior, but if the warrior moves further away the warrior will not be hit.

From a space adjacent to an archer, the warrior will take 6 HP damage to retreat to a safe space.

An archer will not attack on the turn in which the warrior walks from a space at a range of three spaces to a space at a range of two spaces. The archer will attack on the next turn.

#### Fighting One Archer

Assume the warrior starts from a range of three spaces from an archer, and that there are no other enemies in the level that can attack the warrior.

The best strategy to kill the archer in the minimum number of turns is for the warrior to walk towards the archer until they're adjacent and then to attack until the archer is killed. The warrior will take 12 HP of damage.

#### Fighting Two Adjacent Archers

Assume the warrior starts from a range of three spaces from the closest archer.

The best strategy is for the warrior to walk towards the archers until they're adjacent to the first

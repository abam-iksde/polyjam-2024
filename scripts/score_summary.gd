extends Label


const SCORE_SUMMARY_FORMAT = """DISTANCE SCORE    {base}
plus STREAK SCORE    {streak} x 100
plus NOTE SCORE    {notes}
is SCORE    {sum}"""


func _ready():
	var streak := maxf(GameState.max_streak, GameState.streak)
	text = SCORE_SUMMARY_FORMAT.format({
		base = GameState.score,
		streak = streak,
		notes = '0',
		sum = GameState.score + streak * 100,
	})

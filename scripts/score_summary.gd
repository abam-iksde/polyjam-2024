extends Label


const SCORE_SUMMARY_FORMAT = """DISTANCE SCORE    {base}
STREAK SCORE    {streak} x 100
NOTE SCORE    {notes}
TOTAL SCORE    {sum}"""


func _ready():
	var streak := maxf(GameState.max_streak, GameState.streak)
	text = SCORE_SUMMARY_FORMAT.format({
		base = GameState.score,
		streak = streak,
		notes = GameState.note_score,
		sum = GameState.score + GameState.note_score + streak * 100,
	})

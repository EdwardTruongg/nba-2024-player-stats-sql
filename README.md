# NBA-2024-Player-Stats
This project is a SQL-based exploration of NBA player stats from the 2024–25 season. Using data from Basketball Reference, I wrote a series of queries to analyze player performance, efficiency, team scoring depth, and more. The goal was to strengthen my SQL skills by working with real-world sports data and to simulate analysis tasks that an NBA analyst or sports data team might perform.

---

🔧 Tools Used  
- Microsoft SQL Server Management Studio (SSMS)  
- T-SQL  
- NBA player per-game dataset from [Basketball Reference](https://www.basketball-reference.com/leagues/NBA_2025_per_game.html)

---

📊 Key Features  
- Identified top 10 scorers using logic to avoid duplicate rows for traded players  
- Ranked high-volume, high-efficiency 3-point shooters (4+ attempts/game)  
- Found players who averaged a double-double (exactly 2 categories with 10+ per game)  
- Flagged scorers averaging 25+ PPG but shooting under 45% FG  
- Analyzed non-PG players with point guard-like assist and turnover rates  
- Counted which teams had the most 20+ PPG scorers  
- Identified players with balanced stat lines (5+ in points, assists, and rebounds)  
- Filtered for All-Defensive Team candidates based on steals and blocks  
- Highlighted big men (C/PF) with elite playmaking ability (5+ assists/game)  
- Compared pre- and post-trade stats for players with a `2TM` row

---

▶️ How to Run This Project  
1. Open the `nba_sql_analysis.sql` file in SQL Server Management Studio (SSMS)  
2. Make sure your table is named `PlayerStats` and contains all per-game columns such as:
   - `PTS`, `AST`, `TRB`, `FG1`, `STL`, `BLK`, `TOV`, etc.  
3. Run each query section by section — each one is labeled and commented  
4. Optional: add filters like `G >= 10` or `MP > 20` to refine results

---

📚 Learning Takeaways  
Through this project, I learned how to:

- Apply SQL to sports analytics and real-world use cases  
- Use subqueries to isolate player conditions like trades (`2TM` rows)  
- Use `CASE WHEN` logic to count qualifying stat thresholds  
- Filter and sort player stats for efficiency, balance, and performance trends  
- Document SQL code professionally with structured comment blocks  
- Think like a sports analyst and make data-driven comparisons across teams and players

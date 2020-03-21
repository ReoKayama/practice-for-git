majors = ['数学系', '物理系', '地球惑星科学系', 
          '材料系', '応用科学系', '経営工学系', '機械系', '建築系', '制御工学系', '情報工学系',
          '生命理工学系', '土木環境系', '融合理工系']
          
40.times do |n|
    User.create!(email: "dev#{n}@example.com",
                 name: "鈴木#{n}郎",
                 password: "devdev#{n}",
                 password_confirmation: "devdev#{n}",
                 grade: [1, 2, 3, 4].sample,
                 major: majors.sample)
end        

lec_names = ['有機化学第一', '高分子科学実験', 'コミュニケーション論',
             '政治学B', '電磁気学第一', '英語第一', '線形代数学第一',
             '先進物理化学第二', '構造設計第一', '都市設計第一',
             '社会と経済', 'ミクロ経済第二', '集合と位相','宇宙物理',
             'コンピュータサイエンス第一', '触媒化学', 'マテリアル論',
             '金属物性学', 'プラント設計演習', '高分子物理第四', '流体力学',
             'ロボティクス実習', '熱力学第八', '情報工学基礎第二', 'ベイズ推定の基礎',
             'プロトコルと機会学習', '制御工学', '融合の理系人材', '分子生物学', '医薬品基礎'
            ]
days = ['月曜日', '火曜日', '水曜日', '木曜日', '金曜日']
groups = ['理工系教養科目群', '文系教養科目群', '専門科目群', '選択科目群']
methods = ['期末100%', '期末70% 出席30%', 'レポート100%']
attendances = ['毎回有', '時々有', '無']

30.times do |n|
    lec_name = lec_names.first
    lec_names.shift
    professor = '鈴木次郎'
    quarter = [1, 2, 3, 4].sample
    day = days.sample
    period = [1, 2, 3, 4, 5].sample
    group = groups.sample
    major = majors.sample
    grade = [1, 2, 3, 4].sample
    method = methods.sample
    attendance = attendances.sample
    understanding = rand(1..5)
    score = rand(1..100)
    interest = rand(1..5)
    getting_rate = rand(1..100)
    
    Lecture.create!(lec_name: lec_name,
                    professor: professor,
                    t_quarter: quarter,
                    t_day: day,
                    t_period: period,
                    group: group,
                    en_major: major,
                    en_grade: grade,
                    ev_method: method,
                    ev_attendance: attendance,
                    ev_understanding: understanding,
                    ev_score: score,
                    ev_interest: interest,
                    ev_getting: getting_rate)
    
end













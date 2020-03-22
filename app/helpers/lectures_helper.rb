module LecturesHelper
    
    def total_evaluation(lecture)
        understanding_sum = 3
        getting_sum = 3
        interest_sum = 3
        score_sum = 3
        reviews = lecture.reviews
        for review in reviews do
            understanding_sum = understanding_sum + review.understanding
            getting_sum  = getting_sum + review.getting
            interest_sum = interest_sum + review.interest
            score_sum = score_sum + ((review.score-50)/10)
        end
        total_score = (understanding_sum + getting_sum + interest_sum + score_sum) / (4 * (reviews.count + 1))
        ret_score = BigDecimal(total_score.to_s).floor(1).to_f
        return ret_score
    end
    
end

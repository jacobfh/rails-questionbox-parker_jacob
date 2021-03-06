
  json.username @question_username
  json.questionID @question.id
  json.userID @question.user_id
  json.created @question.created_at
  json.updated @question.updated_at
  json.title @question.title
  json.content @question.content
  json.image_url @question.image_url
   json.answers @question.answers do |answer|
   json.id answer.id
   json.answerUsername @answer_username
   json.answerCreated answer.created_at
   json.answerUpdated answer.updated_at
   json.answerTitle answer.title
   json.answerContent answer.content
   json.verify answer.verify_answer
   json.answerUserID answer.user_id
   json.image_url answer.image_url
   end


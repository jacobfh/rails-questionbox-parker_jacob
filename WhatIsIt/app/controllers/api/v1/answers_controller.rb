class Api::V1::AnswersController < ApplicationController
  skip_before_action :verify_authentication

  def index
    @answers = Answer.all
    render json: @answers
  end

  def show
    @answer = Answer.find(params[:id])
    render json: @answer
  end

  def new
    @question = Question.find(params[:question_id])
    if current_user
        @answer = Answer.new
    else
        redirect_to api_v1_question_path(@question), { error: "You must login to create a question" }, status: 401
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    if current_user
      if current_user.id == @answer.user_id
          @question = Question.find(params[:id])
      else
          redirect_to api_v1_question_path, { error: "Only question creator can edit" }, status: 401
      end
    else
      redirect_to new_api_v1_session_path, { error: "You must login to create a question" }, status: 401
    end
  end

  def create
    @question = Question.find(params[:id])
    @user = User.find_by(params[:user_id])
    respond_to do |format|
      if @answer.save!
        send_answer_email(@user)        
        format.json { render :show, status: :created, location: @answer }
      else
        format.json { render json: @answers.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    respond_to do |format|
      if @answer.update(answer_params)
        format.json { render :show, status: :ok, location: @answer }
      else
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if current_user
      if current_user.id == @answer.user_id
        @answer.destroy
          respond_to do |format|
          format.json { head :no_content }
        end
      else
          redirect_to @answer, { error: "Only post creator can delete." }, status: 401
      end
    else
      redirect_to new_api_v1_session_path, { error: "You must login to create a question" }, status: 401
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id, :verify_answer)
    end

    def send_answer_email(user)
      UserMailer.answer(user).deliver_now
    end
end

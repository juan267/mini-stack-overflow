class QuestionsController < ApplicationController
  before_action :fetch_question , only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @answers = Question.find(params[:id]).answers
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
    else
      redirect_to 'new'
    end
  end

  def update
    @question.update(question_params)
    redirect_to @question
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  def up_vote
    # @vote = Vote.new(value: 'true',votable_type: 'question', id:1)
    @question = Question.find(params[:id])
    @question.votes.create
    redirect_to question_path(params[:id])
  end

  def down_vote
    @question = Question.find(params[:id])
    @question.votes.last.destroy
    redirect_to question_path(params[:id])
  end

  private

  def vote_params
    params.require(:vote).permit(:value, :votable_id, :votable_type)
    # params.require(:vote).permit(:id)

  end

  def question_params
    params.require(:question).permit(:title, :content, :user)
  end

  def fetch_question
    @question = Question.find(params[:id])
  end

end

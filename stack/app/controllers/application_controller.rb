class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # This is the votes controller. It works for Questions and Answers
  def vote(value, vote_type, question_id, ques_ans)
    # Add 1 to the votes column
    # @question = current_user.questions.where(params[:question_id]).votes
    @amount = current_user.votes.where(vote_type_id: question_id, vote_type_type: ques_ans).sum(:value)
    print "this is the amount tha twe are looking for " + @amount.to_s
    if (@amount + value).between?(-1,1)
      @question = Question.find(params[:id])
      @vote = Vote.create(value: value, vote_type: @question, user_id: current_user.id)
        # Vote.amount(current_user, @vote.vote_type_id, @vote.vote_type_type)
      if @vote.save
        flash[:notice] = "Thanks for your #{vote_type}!"
        redirect_to questions_path
      else
        flash[:notice] = "You can only vote once"
        redirect_to questions_path
      end
    else 
      flash[:notice] = "You can only vote 1 up or 1 down"
      redirect_to questions_path
   end
     
  
  end

end
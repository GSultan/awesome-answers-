class QuestionsController < ApplicationController
  # this action is to show the form for creating a new question
  # the URL: /questions/new
  # the path helper is: new_question_path
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_question, only: [:edit, :update, :destroy, :show]


  #the before action methods will be executed at the order they are defined.
  # This means the 'quthenticate_user' will be caled beore the 'authorize_access' method. This means that the user will be authenticated when we're inside the ''authorize_access' method so we don't have to check for that.
  before_action :authorize_access, only: [:edit, :update, :destroy]
  #before_action (:find_question, {only: [:edit, :update, :destroy, :show]})
  #the 'before_action' method in here registers a method (usually private)
  #to be executed just before controller actions. this happens within the same
  #request response cycle, which means if you define an instance variable
  #it will be available within the action
  #You can optionally give options: 'only' or 'except' to restrict the actions
  #that this 'before_action' method applies to.
  # Another way of writing it that is less explicit but viable:
  # before_action :find_question, except: [:index, :new, :create]

  def new
    @question = Question.new
  end

  # this action is to handle creating a new question after submitting the form
  # that was shown in the new action
  def create

    #flash works very similar to the session in a sense that it uses cookies
    #to store values that persist through redirect_to or render
    # flash will clear the value as soon as it's read so it doesn't persist
    #through the rest of the requests
    #session[:notice] = 'Question Created!'
    @question = Question.new question_params
    @question.user = current_user
    if @question.save
      # redirect_to question_path({id: @question.id})
      # redirect_to question_path({id: @question})
      flash[:notice] = 'Question Created!'
      redirect_to question_path(@question)
    else
      flash.now[:alert] = 'Please see errors below'
      # if we juse use flash[:alert] in here then the flash message will persist
      # to the next request as well. flash.now[:alert] will make it only show
      # when you render the `:new` template but it won't persist to the next
      # request
      render :new
    end
  end

#this action is to show information about a specific information
#URL: /questions/ :id (for example /questions/123)
#METHOD " GET"


  def show
    # render plain: "In show action"
    @answer = Answer.new
  end


#this action is to show a listings of all the questions
#URL :/questions
#METHOD: GET
  def index
    @questions = Question.order(created_at: :desc).limit(10).offset(10) #give it an instance variable if you wanna share it with a view , and pluralize it because there will be many questions
  end
  #this action is to show a form pre-population with the question's data
  #URL: /questions/:id/edit
  #METHOD : GET
  def edit
    @question = Question.find params[:id]
    #every action is independent of any other action. This page is full of actions.
  end

  #this action is to capture the params from the form submission form the edit
  #action in order to update a questions
  #URL :/questions/:id
  #METHOD: PATCH
  def update
      # when searching for question params it will go one step higher , from inside method , to inside class
      if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit
    end
  end



  #this action handles deleting a question
  #URL :/questions/:id
  #METHOD: DELETE
  def destroy
    @question.destroy
    # adding 'notice: 'Question deleted' to the redirect_to line will set a
    #flash notice message as we did the create / update actions notice that this #only works for redirect and not for render
    redirect_to questions_path, notice: 'Question deleted'
  end

private

  def question_params
    params.require(:question).permit([:title, :body])
  end

  def find_question
    @question = Question.find params[:id]
  end

  def authorize_access
    unless can? :manage, @question
      # head :unauthorized #this will send an empty HTTP response with 401 code
      redirect_to root_path, alert: 'access denied'
    end
  end
end

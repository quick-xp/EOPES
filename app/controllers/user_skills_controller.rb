class UserSkillsController < ApplicationController

  # GET /user_skills
  # GET /user_skills.json
  def index
    @user_skill_form = UserSkillForm.new.get_user_skill(get_current_user_id)

  end

  # POST /user_skills
  # POST /user_skills.json
  def create
    @user_skill_form = UserSkillForm.new(user_skill_params)

    respond_to do |format|
      if @user_skill_form.save(get_current_user_id)
        format.html { redirect_to user_skills_url, notice: 'User skill was successfully updated.' }
        format.json { render :index, status: :created, location: @user_skill_form }
      else
        format.html { render :index }
        format.json { render json: @user_skill_form.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_user_skill
    #  @user_skill = UserSkill.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_skill_params
      params.require(:user_skill_form).permit(:skill_3380,:skill_3388)
    end
end

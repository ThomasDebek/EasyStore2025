class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      return redirect_to root_path, status: :see_other
    end
  end

  def destroy
    super do
      return redirect_to root_path, status: :see_other
    end
  end

end
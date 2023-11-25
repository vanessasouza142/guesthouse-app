class Api::V1::GuesthousesController < ActionController::API

  def index
    guesthouses = Guesthouse.active
    if params[:search].present?
      guesthouses = guesthouses.where("brand_name LIKE ?", "%#{params[:search]}%")
    end    
    render status: 200, json: guesthouses.as_json(only: [:brand_name, :city])
  end

  def show
    begin
      guesthouse = Guesthouse.find(params[:id])
      if guesthouse.inactive?
        return render status: 422, json: { error: 'Pousada inativa no momento' }
      else
        average_score = guesthouse.average_score
        guesthouse_json = guesthouse.as_json(except: [:corporate_name, :registration_number, :created_at, :updated_at, :user_id, :status])      
        guesthouse_json["check_in"] = guesthouse["check_in"].to_time.strftime('%H:%M')
        guesthouse_json["check_out"] = guesthouse["check_out"].to_time.strftime('%H:%M')  
        guesthouse_json["average_score"] = average_score.nil? ? '' : average_score.round(1)
        return render status: 200, json: guesthouse_json
      end
    rescue
      render status: 404
    end
  end

end
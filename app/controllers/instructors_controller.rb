class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :response_errors_message
    rescue_from ActiveRecord::RecordInvalid, with: :response_errors
    def index
        instructors = Instructor.all
        render json: instructors
    end

    def create
        instructor = Instructor.create!(params_instructor)
        render json: instructor, status: :created
    end

    def update
        instructor = find_params
        instructor.update!(params_instructor)
        render json: instructor
    end

    def destroy
        instructor = find_params
        instructor.destroy
        head :no_content
    end

    def show
        instructor = find_params
        render json: instructor, include: :students
    end

    private

    def find_params
        Instructor.find(params[:id])
    end
    def params_instructor
        params.permit(:name)
    end

    def response_errors(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
    def response_errors_message
        render json: {error: "Instructor not found"}, status: :not_found
    end

end

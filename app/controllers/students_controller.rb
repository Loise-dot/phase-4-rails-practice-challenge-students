class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :response_errors_message
    rescue_from ActiveRecord::RecordInvalid, with: :response_errors
    def index
        students = Student.all
        render json: students
    end

    def create
        student = Student.create!(params_student)
        render json: student, status: :created
    end

    def update
        student = find_params
        student.update(update_student)
        render json: student
    end

    def destroy
        student = find_params
        student.destroy
        head :no_content
    end

    def show
        student = find_params
        render json: student
    end

    private

    def find_params
        Student.find(params[:id])
    end
    def params_student
        params.permit(:name, :age, :major, :instructor_id)
    end
    def update_student
        params.permit(:name, :age, :major)
    end

    def response_errors(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
    def response_errors_message
        render json: {error: "Student not found"}, status: :not_found
    end

end


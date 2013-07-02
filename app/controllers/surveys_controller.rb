# -*- coding: utf-8 -*-

class SurveysController < ApplicationController
  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all.map { |e| e[:aggregation] = aggregate(e) }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @surveys }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    @survey = Survey.find_by_user(params[:id])
    @aggregation = aggregate(@survey)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: {survey: @survey, aggregation: @aggregation}}
    end
  end

  def aggregate(survey)
    aggregation = {}
    # - 1요인 해당 문항: 1, 5, 9, 12, (13)
    # - 3요인 해당 문항: 3, 7, (10), 14
    # - 4요인 해당 문항: 4, (8), 11, 15
    aggregation[:part1] = survey.q1 + survey.q5 + survey.q12 + (5 - survey.q13)
    aggregation[:part3] = survey.q3 + survey.q7 + (5 - survey.q10) + survey.q14
    aggregation[:part4] = survey.q4 + (5 - survey.q8) + survey.q11 + survey.q15
    aggregation[:total] = aggregation[:part1] + aggregation[:part3] + aggregation[:part4]

    # 집단분류
    #  - 고위험군: ① 총점 45점 이상
    #                ② 1요인 16점 이상 & 3요인 13점 이상  & 4요인 14점 이상
    #  - 잠재적위험군: ① 42점 이상~44점 이하
    #                ② 1요인 14점 이상  ③ 3요인 12점 이상  ④ 4요인 13점 이상
    #  - 일반사용자군: ① 41점 이하
    #                ② 1요인 13점 이하  ③ 3요인 11점 이하 ④ 4요인 12점 이하
    aggregation[:class] = classificate(aggregation)

    return aggregation
  end

  def classificate(aggregation)
    if aggregation[:total] >= 45 && aggregation[:part1] >= 16 && aggregation[:part3] >= 13 && aggregation[:part4] >= 14
      return "고위험군" # encoding: UTF-8
    elsif aggregation[:total] >= 42 && aggregation[:part1] >= 14 && aggregation[:part3] >= 12 && aggregation[:part4] >= 13
      return "잠재적위험군" # encoding: UTF-8
    end
    return "일반사용자군" # encoding: UTF-8
  end 

  # GET /surveys/new
  # GET /surveys/new.json
  def new
    @survey = Survey.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @survey }
    end
  end

  # GET /surveys/1/edit
  def edit
    @survey = Survey.find_by_user(params[:id])
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(params[:survey])

    respond_to do |format|
      if @survey.save
        format.html { render :thanks, notice: 'Survey was successfully created.' }
        format.json { render json: @survey, status: :created, location: @survey }
      else
        format.html { render action: "new" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.json
  def update
    @survey = Survey.find_by_user(params[:id])

    respond_to do |format|
      if @survey.update_attributes(params[:survey])
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey = Survey.find_by_user(params[:id])
    @survey.destroy

    respond_to do |format|
      format.html { redirect_to surveys_url }
      format.json { head :no_content }
    end
  end
end

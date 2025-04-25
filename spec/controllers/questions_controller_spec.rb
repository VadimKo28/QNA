require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe "GET #index" do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before do
      get :show, params: { id: question }
    end

    it "render show view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { login(user) }
    before { get :new }

    it "render view new" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    before { login(user) }
    before do
      get :edit, params: { id: question }
    end

    it "render edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    before { login(user) }

    context "with valid attributes" do
      it "save question" do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it "redirect to show" do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context "with invalid attributes" do
      it "does not save question" do
        expect { post :create, params: { question: attributes_for(:question, :invalid) } }.to_not change(Question, :count)
      end

      it "render new view" do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before { login(user) }

    context "with valid attributes" do
      it "assigns the requested questios to let @question" do
        patch :update, params: { id: question, question: attributes_for(:question, :invalid) }
        expect(assigns(:question)).to eq question
      end

      it "changes question attribute" do
        patch :update, params: { id: question, question: { title: 'new_title', body: 'new_body' } }

        question.reload
        expect(question.title).to eq 'new_title'
        expect(question.body).to eq 'new_body'
      end

      it "redirect to question" do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(response).to redirect_to question
      end
    end

    context "with invalid attributes" do
      before { login(user) }
      before do
        patch :update, params: { id: question, question: attributes_for(:question, :invalid) }
      end

      it "do not change questions" do
        question.reload
        expect(question.title).to eq "MyString"
        expect(question.body).to eq "MyText"
      end

      it "render edit" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DLETE #destroy" do
    before { login(user) }

    let!(:question) { create(:question) }
    it "delete question" do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      expect(response).to redirect_to questions_path
    end
  end
end

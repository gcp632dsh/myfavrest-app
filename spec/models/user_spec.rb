require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:community) { FactoryBot.create(:community) }

  # ユーザID,メール,パスワードがあれば有効な状態であること
  it "is valid with a email and password" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 存在性チェック
  describe "test of presence" do
    # メールアドレスがなければ無効な状態であること
    it "is invalid without a email" do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # パスワードがなければ無効な状態であること
    it "is invalid without a password" do
      user.password = ""
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
  end

  # 一意性チェック
  describe "test of uniqueness" do
    # 重複したメールなら無効な状態であること
    it "is invalid with a duplicate email" do
      user.save
      dupulicate_user = FactoryBot.build(:user, email: user.email)
      dupulicate_user.valid?
      expect(dupulicate_user.errors[:email]).to include("はすでに存在します")
    end
  end

  # メールアドレスは規定の正規表現に従うこと
  describe "email obeys VALID_EMAIL_REGEX" do
    # ドメインを持たないメールアドレスは無効であること
    it "is invalid with no domain" do
      user.email = "aaa"
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
    # ドメインを持つメールアドレスは有効であること
    it "is valid with a domain" do
      user.email = "aaa@ruby.com"
      expect(user).to be_valid
    end
  end

  # 長さの確認
  describe "test of length" do
    # 31文字以上のユーザ名は無効であること
    it "is invalid with username with more than 30 characters" do
      user.username = "あ" * 31
      user.valid?
      expect(user.errors[:username]).to include("は30文字以内で入力してください")
    end
    # 30文字以内のユーザ名は有効であること
    it "is valid with username with 30 characters" do
      user.username = "あ" * 30
      expect(user).to be_valid
    end

    # 5文字のパスワードは無効であること
    it "is invalid with password with 5 characters" do
      user.password = "p" * 5
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
    # 129文字のパスワードは無効であること
    it "is invalid with password with 129 characters" do
      user.password = "p" * 129
      user.valid?
      expect(user.errors[:password]).to include("は128文字以内で入力してください")
    end
    # 6文字のパスワードは有効であること
    it "is valid with password with characters betwen 6 and 128" do
      user.password = "p" * 6
      user.valid?
      expect(user).to be_valid
    end
    # 128文字のパスワードは有効であること
    it "is valid with password with characters betwen 6 and 128" do
      user.password = "p" * 128
      user.valid?
      expect(user).to be_valid
    end
  end

  # フォロー・アンフォローを行う
  describe "can follow or unfollow the user" do
    # フォローしているとき
    context "when user1 follow user2" do
      before do
        user1.follow(user2.id)
      end

      # 既にフォローしているユーザをフォローできない
      it "user1 cannot follow user2" do
        flw = user1.follow(user2.id)
        flw.valid?
        expect(flw.errors[:followed_id]).to include("はすでに存在します")
      end
      # フォロー確認でtrueとなる
      it "result of following check is true" do
        flw = user1.following?(user2)
        expect(flw).to eq true
      end
      # アンフォローできる
      it "user1 can unfollow user2" do
        flw = user1.unfollow(user2.id)
        expect(flw).to be_valid
      end
    end

    # フォローしていないとき
    context "when user1 does not follow user2" do
      # フォロー確認でfalseとなる
      it "result of following check is false" do
        flw = user1.following?(user2)
        expect(flw).to eq false
      end
      # フォローできる
      it "user1 can follow user2" do
        flw = user1.follow(user2.id)
        flw.valid?
        expect(flw).to be_valid
      end
    end
  end

  # 画像のアップロード
  describe "check image upload" do
    # 画像を設定できること（jpg）
    it "can set an image of jpg" do
      image_path = Rails.root.join("app/assets/images/homeImg.jpg")
      user.image.attach(io: File.open(image_path), filename: 'homeImg.jpg', content_type: 'image/jpeg')
      user.save
      expect(user.image).to be_attached
    end

    # 画像を設定できること（jpeg）
    it "can set an image of jpeg" do
      image_path = Rails.root.join("app/assets/images/test_img.jpeg")
      user.image.attach(io: File.open(image_path), filename: 'test_img.jpeg', content_type: 'image/jpeg')
      user.save
      expect(user.image).to be_attached
    end

    # 画像を設定できること（gif）
    it "can set an image of gif" do
      image_path = Rails.root.join("app/assets/images/test_img.gif")
      user.image.attach(io: File.open(image_path), filename: 'test_img.gif', content_type: 'image/gif')
      user.save
      expect(user.image).to be_attached
    end

    # 画像を設定できること（png）
    it "can set an image of png" do
      image_path = Rails.root.join("app/assets/images/test_img.png")
      user.image.attach(io: File.open(image_path), filename: 'test_img.png', content_type: 'image/png')
      user.save
      expect(user.image).to be_attached
    end

    # 1MBを超える画像はアップロードできないこと
    it "can not upload an image over 1MB" do
      image_path = Rails.root.join("app/assets/images/over_1MB.jpg")
      user.image.attach(io: File.open(image_path), filename: 'over_1MB.jpg', content_type: 'image/jpeg')
      user.valid?
      expect(user.errors[:image]).to include "は1MB以下にする必要があります"
    end

    # ファイル拡張子が不適切な場合はアップロードできないこと
    it "can not upload an inappropriate file extension" do
      image_path = Rails.root.join("app/assets/images/inappropriate_image.csv")
      user.image.attach(io: File.open(image_path), filename: 'inappropriate_image.csv', content_type: 'text/csv')
      user.valid?
      expect(user.errors[:image]).to include "ファイル拡張子が適切ではありません"
    end
  end

  # 削除の依存関係
  describe "dependent: destoy" do
    context "relation of other models" do
      before do
        @com = Community.create(name: "1" * 8, create_user_id: user.id, publish_flg: 1)
      end

      # 削除すると、紐づく店舗も全て削除されること
      it "destroys all posts when deleted" do
        2.times { FactoryBot.create(:post, user: user, community: @com) }
        expect { user.destroy }.to change(user.posts, :count).by(-2)
      end

      # 削除すると、紐づくいいねも全て削除されること
      it "destroys all likes when deleted" do
        post = FactoryBot.create(:post, user: user, community: @com)
        Like.create(user_id: user.id, post_id: post.id)
        expect { user.destroy }.to change(user.likes, :count).by(-1)
      end

      # 削除すると、紐づく口コミも全て削除されること
      it "destroys all comments when deleted" do
        post = FactoryBot.create(:post, user: user, community: @com)
        Comment.create(content: "test", user_id: user.id, post_id: post.id, score: 5, visitday: "2020/09/08")
        expect { user.destroy }.to change(user.comments, :count).by(-1)
      end

      # 削除すると、紐づく所属情報も全て削除されること
      it "destroys all belongings when deleted" do
        Belonging.create(user_id: user.id, community_id: @com.id)
        expect { user.destroy }.to change(user.belongings, :count).by(-1)
      end

      # 削除すると、紐づく加入申請も全て削除されること
      it "destroys all applies when deleted" do
        Apply.create(user_id: user.id, community_id: @com.id)
        expect { user.destroy }.to change(user.applies, :count).by(-1)
      end
    end

    # フォロー/フォロワーの削除の依存関係
    context "relation of follow and follower" do
      before do
        user1.follow(user2.id)
      end

      # 削除すると、紐づくフォローも全て削除されること
      it "destroys all follows when deleted" do
        expect { user1.destroy }.to change(user1.follower, :count).by(-1)
      end

      # 削除すると、紐づくフォロワーも全て削除されること
      it "destroys all followers when deleted" do
        expect { user2.destroy }.to change(user2.followed, :count).by(-1)
      end
    end
  end
end

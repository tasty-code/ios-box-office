//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    // MARK: - Private
    private let networkService = NetworkService()
    private var dailyBoxOffice: DailyBoxOfficeDTO?
    private var movieDetail: MovieDetailDTO?
    
    private var movieCollectionView: UICollectionView! = nil
    private var movieDataSource: UICollectionViewDiffableDataSource<Section, MovieDTO>! = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        let sample = DailyBoxOfficeEndPoint(date: "20230510")
        updateData(from: sample) {
            self.dailyBoxOffice = $0
            DispatchQueue.main.async {
                self.applyMovieDataSource()
            }
        }
    }
    
    // MARK: - Private function
    private func setup() {
        configureMovieCollectionView()
        configureMovieDataSource()
        configureUI()
    }
    
    // MARK: - DataSource
    private func configureMovieDataSource() {
        // MARK: - CellRegistration
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MovieDTO> { cell, indexPath, item in
            // config 생성
            var config = cell.defaultContentConfiguration()
            
            // 랭크, 등락 Label생성
            let rankLabel = UILabel()
            rankLabel.textAlignment = .center
            rankLabel.text = item.rank
            rankLabel.font = .preferredFont(forTextStyle: .title1)
            
            
            let rankStatusLabel = UILabel()
            rankStatusLabel.textAlignment = .center
            
            let rankStatusImage = UIImageView()
            
            let rankStatusStackView = UIStackView(arrangedSubviews: [rankStatusImage, rankStatusLabel])
            rankStatusStackView.axis = .horizontal
            rankStatusStackView.alignment = .center
            
            let leftStackView = UIStackView(arrangedSubviews: [rankLabel, rankStatusStackView])
            leftStackView.axis = .vertical
            
            cell.accessories.append(.customView(configuration: .init(customView: leftStackView, placement: .leading())))
            
            // disclosureIndicator 추가
            cell.accessories.append(.disclosureIndicator())
            
            // 랭크, 등락 text 추가
            if item.rankOldAndNew == "NEW" {
                rankStatusLabel.text = "신작"
                rankStatusLabel.textColor = .systemRed
            }
            else {
                if item.rankInten == "0" {
                    rankStatusLabel.text = "-"
                    rankStatusStackView.removeArrangedSubview(rankStatusImage)
                }
                else if item.rankInten.hasPrefix("-") {
                    rankStatusLabel.text = item.rankInten.replacingOccurrences(of: "-", with: "")
                    rankStatusImage.image = UIImage(systemName: "arrowtriangle.up.fill")
                    rankStatusImage.tintColor = .systemRed
                }
                else {
                    rankStatusLabel.text = item.rankInten
                    rankStatusImage.image = UIImage(systemName: "arrowtriangle.down.fill")
                    rankStatusImage.tintColor = .systemBlue
                }
            }

            // 텍스트 입력
            let todayCount = item.audienceCount.formatDecimal() ?? ""
            let totalCount = item.audienceAcc.formatDecimal() ?? ""

            config.text = item.name
            config.secondaryText = "오늘 \(todayCount) / 총 \(totalCount)"
            config.textProperties.font = .preferredFont(forTextStyle: .title3)
            config.secondaryTextProperties.font = .preferredFont(forTextStyle: .subheadline)
            
            // 설정 완료
            cell.contentConfiguration = config
        }
        
        // MARK: - 위에서 만든 Data 등록
        movieDataSource = UICollectionViewDiffableDataSource<Section, MovieDTO>(collectionView: movieCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = self.movieCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        DispatchQueue.main.async {
            self.applyMovieDataSource()
        }
    }
    
    private func configureUI() {
        view.addSubview(movieCollectionView)
    }
    
    private func configureMovieCollectionView() {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        if #available(iOS 14.5, *) {
            config.separatorConfiguration.bottomSeparatorVisibility = .hidden
            config.separatorConfiguration.topSeparatorVisibility = .visible
            config.separatorConfiguration.topSeparatorInsets = .init(top: 0, leading: -100, bottom: 0, trailing: -100)
        }
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        movieCollectionView = collectionView
    }
    
    private func updateData<T: APIRepresentable, E: EndPointProtocol>(from api: E, completion: @escaping (T?) -> Void) where E.DTO == T {
        networkService.fetchData(endPoint: api) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    private func applyMovieDataSource() {
        let movies = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieDTO>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies ?? [])
        movieDataSource.apply(snapshot)
    }
    
}

fileprivate extension String {
    
    func formatDecimal() -> String? {
        guard let number = Int(self) else {
            return nil
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))
    }
    
}

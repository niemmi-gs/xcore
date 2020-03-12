//
// Xcore
// Copyright © 2017 Xcore
// MIT license, see LICENSE file for details
//

import WebKit

extension WKWebsiteDataStore {
    public enum RemoveDataType {
        /// All the available data types.
        case all

        /// Only cache.
        case cache

        fileprivate var dataTypes: Set<String> {
            switch self {
                case .all:
                    return WKWebsiteDataStore.allWebsiteDataTypes()
                case .cache:
                    return WKWebsiteDataStore.allWebsiteCacheTypes()
            }
        }
    }

    public func remove(_ type: RemoveDataType, _ completion: (() -> Void)? = nil) {
        fetchDataRecords(ofTypes: type.dataTypes) { [weak self] records in
            self?.removeData(ofTypes: type.dataTypes, for: records) {
                completion?()
            }
        }
    }
}

extension WKWebsiteDataStore {
    private static func allWebsiteCacheTypes() -> Set<String> {
        var result: Set<String> = [
            WKWebsiteDataTypeDiskCache,
            WKWebsiteDataTypeMemoryCache,
            WKWebsiteDataTypeOfflineWebApplicationCache
        ]

        if #available(iOS 11.3, *) {
            result.insert(WKWebsiteDataTypeFetchCache)
        }

        return result
    }
}

#ifndef GDK_GA_TX_HPP
#define GDK_GA_TX_HPP
#pragma once

#include "containers.hpp"

namespace ga {
namespace sdk {
    class ga_session;

    nlohmann::json create_ga_transaction(ga_session& session, const nlohmann::json& details);

    void sign_input(ga_session& session, const wally_tx_ptr& tx, uint32_t index, const nlohmann::json& u,
        const std::string& der_hex);

    std::vector<nlohmann::json> get_ga_signing_inputs(const nlohmann::json& details);

    nlohmann::json sign_ga_transaction(ga_session& session, const nlohmann::json& details);

    nlohmann::json blind_ga_transaction(ga_session& session, const nlohmann::json& details);

} // namespace sdk
} // namespace ga

#endif
